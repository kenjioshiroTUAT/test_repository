//
// for async. serial (RS232C)
//   FIFO version
// 2011-12-25 Mitaro Namiki
// 2012-01-01 MN for 16bit
// 2012-02-14 sakamoto for wen
// 2012-04-19 MN  FIFO version
// 2012 04 23 sakamto bug fix
// 2012-11-27,28 MN  buscon32
// 2012-12-04 MN buscon16
// ----
// 2016-11-13,16 12-14 MN for Geyser5, buscon16,auto ready

////`define BUSCON32
`define BUSCON16

////`define BIG_ENDIAN

//---- serial divider
//for sim 
`define DIVCLOCK 3'd2
`define DIVBUS   2:0
//----
// set Div = Clock / baud / 16 - 1
// example.0 Clock = 40MHz
/// ((40MHz / 9600 / 16 = 260.4) -> 261) - 1 -> 260 (0.16%)
//`define DIVCLOCK 9'd261
//`define DIVBUS   8:0
// example.1 Clock = 25MHz
/// ((25MHz / 19200 / 16 = 81.38) -> 81) - 1 -> 80 (0.46%)
////`define DIVCLOCK   7'd80
////`define DIVBUS   6:0
/*------------------------------------
Address map: macro defined endian
0: RxFIFO READ  bit 7:0   BIG:byte@3, hw@2
4: TxFIFO WRITE bit 7:0   BIG:byte@7, hw@6
8: Status READ            BIG:byte@b, hw@a
   bit 0: RxFIFO valid data
       1: RxFIFO full
       2: TxFIFO empty
       3: TxFIFO full
       4: Intr enabled
       5: Overrun error  (recv over run. when read, reset 0)
       6: Frame error    (when read, reset 0)
       7: Parity error   (reserved, always 0)
C: Control WRITE          BIG:byte@f, hw@c
   bit 0: Reset Tx FIFO  (when write 1, reset TxFIFO)
       1: Reset Rx FIFO  (when write 1, reset RxFIFO)
       4: Enable Intr
------------------------------------*/
`ifdef BUSCON32
module UARTLiteBusCon32( // register, auto ready
    input wire		Clk,
    input wire		Reset_,
    input wire [31:0]	Address,
    input wire [3:0]	ByteEn,
    input wire		OEn,     // 1: read data
    input wire		WEn,     // 1: write data (single shot)
    input wire		Done,
    input wire [31:0]	WrData, 
    input wire		RxData,
    output wire [31:0]  RdData,
    output wire		TxData,
    output wire		Ready,
    output wire		Interrupt
);
    wire [7:0] RdData8;
    assign Ready = 1'b1; // auto ready
`ifdef BIG_ENDIAN
    wire Enable =  ByteEn[3];
    wire IsByte = (ByteEn == 4'b1000);
    wire IsHW = (ByteEn == 4'b1100);
    wire IsW  = (ByteEn == 4'b1111);
    wire [7:0] WrData8 = 
		  IsByte ? WrData[31:24]
		: IsHW   ? WrData[23:16]
		: WrData[7:0] ;
    assign RdData[31:0] = !OEn ? 32'b0
			: IsByte ? {RdData8, 24'b0}
			: IsHW   ? {8'b0,RdData8, 16'b0}
			: IsW    ? {24'b0, RdData8}
			: 32'b0;
`else // !`ifdef BIG_ENDIAN // untested
    wire Enable =  ByteEn[0];
    wire [7:0] WrData8 = WrData[7:0] ;
    assign RdData[31:0] = !OEn ? 32'b0
			: {24'b0, RdData8}
`endif // end ifdef BIG_ENDIAN

    UARTControllerCore MyUARTLite32(
	.Clk(Clk),
	.Reset_(Reset_),
	.Address(Address[3:0]),
	.Enable(Enable),
	.OEn(OEn),
	.WEn(WEn),
	.Done(Done),
	.WrData(WrData8[7:0]), 
	.RxData(RxData),
	.RdData(RdData8[7:0]),
	.TxData(TxData),
	.Interrupt(Interrupt)
    );
endmodule
`endif

`ifdef BUSCON16
module UARTLiteBusCon16( // register, auto ready
    input wire		Clk,
    input wire		Reset_,
    input wire		Strobe,
    input wire [3:0]	ByteEn,
    input wire [31:0]	Address,
    input wire [1:0]	Mode16, // 01:byte or halfword, 10:word, 11:burst
    input wire		OEn,     // 1: read data
    input wire		WEn,     // 1: write data (single shot)
    input wire [15:0]	WrData, 
    input wire		RxData,
    output wire [15:0]  RdData,
    output wire		TxData,
    output wire		Interrupt
);
    wire [7:0] RdData8;
    wire IsUpper =  Address[1];
    wire IsLower = !Address[1];
`ifdef BIG_ENDIAN
    wire Enable =  ByteEn[3];
    wire Is1HW  = (Mode16[1:0] == 2'b01);
    wire IsWord = (Mode16[1:0] == 2'b10);
    wire [7:0] WrData8 =  Is1HW  ? (IsUpper ? WrData[15:8] : 8'b0)
			: IsWord ? (IsLower ? WrData[7:0]  : 8'b0)
 	                : WrData[31:24];
    assign RdData[15:0] = !OEn ? 16'b0
			: Is1HW  ? (IsUpper ? {RdData8, 8'b0} : 16'b0)
			: IsWord ? (IsLower ? {8'b0, RdData8} : 16'b0)
			: 16'b0;
`else // !`ifdef BIG_ENDIAN
    wire Enable = ByteEn[0];
    wire [7:0]  WrData8 =  WrData[7:0];
    assign RdData[15:0] = {8'b0, (OEn && IsLower) ? RdData8 : 8'b0};
`endif // ifdef BIG_ENDIAN

    UARTControllerCore MyUARTLite16(
	.Clk(Clk),
	.Reset_(Reset_),
	.Address(Address[3:0]),
	.Enable(Enable),
	.OEn(OEn),
	.WEn(WEn),
	.Done(1'b1),
	.WrData(WrData8[7:0]), 
	.RxData(RxData),
	.RdData(RdData8[7:0]),
	.TxData(TxData),
	.Interrupt(Interrupt)
    );
endmodule
`endif

module UARTControllerCore (
    input wire 	      Clk,
    input wire 	      Reset_,
    input wire [3:0]  Address,
    input wire 	      Enable,
    input wire 	      OEn, // 1: read data
    input wire 	      WEn, // 1: write data (single shot)
    input wire 	      Done,
    input wire [7:0]  WrData, 
    input wire 	      RxData,
    output wire [7:0] RdData,
    output wire       TxData,
    output wire       Interrupt
);
    wire IsRxFIFO = (Address[3:2] == 2'b00) && Enable;
    wire IsTxFIFO = (Address[3:2] == 2'b01) && Enable;
    wire IsStatus = (Address[3:2] == 2'b10) && Enable;
    wire IsCntl   = (Address[3:2] == 2'b11) && Enable;

    reg 	RegIntrEnable;
    reg		RegRxFErr, RegRxOverRun;

    wire	SClk16;
    wire	WEnCntl = IsCntl && WEn;
    wire	TxResetClear = !Reset_ || (WEnCntl && WrData[0]);
    wire	RxResetClear = !Reset_ || (WEnCntl && WrData[1]);

    wire [7:0]	RxFIFOData, RxOutData, TxFIFOData;
    wire	RxFErr;
    wire	GetTxFIFO, PutRxFIFO; 
    wire	TxFIFOEmpty, TxFIFOFull, TxTransStop, TxTransmitting;
    wire	RxFIFOEmpty, RxFIFOFull;
    wire	RxOverRun = (RxFIFOFull && PutRxFIFO);
    wire	RxReady = !RxFIFOEmpty;
    wire	TxTEmpty = TxFIFOEmpty && !TxTransmitting;
    wire	GetRxFIFO = OEn && IsRxFIFO && Done;
    wire	PutTxFIFO = WEn && IsTxFIFO;
    wire [7:0]	Status = {1'b0, RegRxFErr, RegRxOverRun, RegIntrEnable,
			  TxFIFOFull, TxTEmpty, RxFIFOFull, RxReady};
    assign 	RdData[7:0] =    !OEn ? 8'b0
				: IsRxFIFO ? RxFIFOData[7:0]
				: IsStatus ? Status[7:0]
				: 8'b0;
    assign	Interrupt = RegIntrEnable && (RxReady || TxTransStop);
	 
    always @(posedge Clk or negedge Reset_) begin
    if(!Reset_) begin
 	RegIntrEnable <= 0; RegRxFErr <= 0; RegRxOverRun <= 0;
    end else begin
	if(WEn) begin
	    if(IsCntl) RegIntrEnable <= WrData[4];
	end else if(OEn && Done) begin
	    if(IsStatus) begin
		RegRxFErr <= 1'b0; RegRxOverRun <= 1'b0;
	    end
	end
	if(RxFErr) RegRxFErr <= 1'b1;
	if(RxOverRun) RegRxOverRun <= 1'b1;
    end // if(!Reset_)
    end // always @(posedge Clk)

    // transmitter
    TxSerial TxSerialUnit(
	.Clk		(Clk),
	.SClk16		(SClk16),
	.ResetClear	(TxResetClear),
	.TxFIFOEmpty	(TxFIFOEmpty),
	.TxTransmitting	(TxTransmitting),
	.TxTransStop	(TxTransStop),
	.TxGetData	(GetTxFIFO),
	.TxData		(TxFIFOData[7:0]),
	.TxSData	(TxData)
    );
    SerialFIFO TxFIFOUnit (
	.Clear		(TxResetClear),
	.Clk		(Clk),
	.PutEnable	(PutTxFIFO),
	.PutData	(WrData[7:0]),
	.GetEnable	(GetTxFIFO),
	.GetData	(TxFIFOData[7:0]),
	.Empty		(TxFIFOEmpty),
	.Full		(TxFIFOFull)
    );

    // receiver
    RxSerial RxSerialUnit(
	  .Clk		(Clk),
	  .SClk16	(SClk16),
	  .ResetClear	(RxResetClear),
	  .RxSData	(RxData),
	  .RxFramingErr	(RxFErr),
	  .RxPutData	(PutRxFIFO),
	  .RxOutData	(RxOutData[7:0])
    );
	 
    SerialFIFO RxFIFOUnit (
	.Clear		(RxResetClear),
	.Clk		(Clk),
	.PutEnable	(PutRxFIFO),
	.PutData	(RxOutData[7:0]),
	.GetEnable	(GetRxFIFO),
	.GetData	(RxFIFOData[7:0]),
	.Empty		(RxFIFOEmpty),
	.Full		(RxFIFOFull)
    );

    SerialClockDivider SerialClockDivider(
	.Clk		(Clk),
	.Reset_		(Reset_),
	.SClk16		(SClk16)	
    );
endmodule

module TxSerial(
    input wire		Clk,
    input wire		SClk16,
    input wire		ResetClear,
    input wire		TxFIFOEmpty,
    output wire		TxTransmitting,
    output wire		TxTransStop,
    output wire		TxGetData,
    input wire [7:0]	TxData,
    output wire		TxSData
);
    reg [3:0] 	RegTxState; // every bit has some means
`define TXIDLE  4'b0000
`define TXEXEC  4'b0001
`define TXSTART 4'b0100
`define TXDATAS 4'b1000
`define TXDATAE 4'b1111
`define TXSTOP  4'b0010

    reg [7:0] 	RegTxShiftReg;
    reg		RegTxTransDone, RegTxGetData, RegTxDone, RegTxTransStop;
    reg [3:0]	RegDiv;
    assign 	TxSData = RegTxState[3] ? RegTxShiftReg[0] : !RegTxState[2];
    assign 	TxGetData = RegTxGetData;
    assign 	TxTransmitting = (|RegTxState[3:1]) ;
    assign 	TxTransStop = RegTxTransStop;

    always @(posedge Clk or posedge ResetClear) begin
    if(ResetClear) begin
	RegTxState <= `TXIDLE ; RegTxShiftReg <= 0;
	RegTxTransDone <= 0; RegTxTransStop <= 0;
	RegDiv <= 15; RegTxGetData <= 0;
    end else if(!SClk16) begin
	RegTxTransStop <= 1'b0; RegTxGetData <= 0;
    end else if((|RegDiv)) begin
	RegDiv <= RegDiv - 1;
    end else begin // 16 * serial clock
	RegDiv <= 15 ;
	case (RegTxState)
	`TXIDLE: RegTxState <= `TXEXEC; // idle 
	`TXEXEC: begin
	    if(TxFIFOEmpty) begin
		if(RegTxTransDone) begin
		    RegTxTransDone <= 1'b0;
		    RegTxTransStop <= 1'b1;
		end
	    end else begin // data from TxFIFO
		RegTxGetData <= 1'b1;
		RegTxShiftReg[7:0] <= TxData[7:0];
		RegTxState <= `TXSTART;
	    end 
	end
	`TXSTART: RegTxState <= `TXDATAS;
	default: begin // 000-110
	    RegTxState <= RegTxState + 1;
	    RegTxShiftReg[7:0] <= {1'b0, RegTxShiftReg[7:1]};
	end
	`TXDATAE: RegTxState <= `TXSTOP; // 111
	`TXSTOP: begin
	    RegTxTransDone <= 1'b1;
	    RegTxState <= `TXIDLE;
	end
	endcase
    end // if(!Reset_)
    end // always @(posedge TxClk
endmodule // send data

module RxSerial(
    input wire		Clk,
    input wire		SClk16,
    input wire		ResetClear,
    input wire		RxSData,
    output wire		RxFramingErr,
    output wire		RxPutData,
    output wire [7:0]	RxOutData
);
    reg [7:0] 	RegRxShiftReg;
    reg [1:0]   RegState;
`define SRIDLE  2'd0
`define SRSTART 2'd1
`define SRRECV  2'd2
`define SRSTOP  2'd3
    reg [3:0]	RegCount;
    reg [2:0]	RegBits;
    wire [3:0]	DeclCount = RegCount[3:0] - 1;
    wire	NzCount = (|RegCount);
    reg 	RegFrErr, RegRxPutData;

    assign RxPutData = RegRxPutData;
    assign RxFramingErr = RegFrErr;
    assign RxOutData[7:0] = RegRxShiftReg[7:0];

    always @(posedge Clk or posedge ResetClear) begin
    if(ResetClear) begin
	RegRxShiftReg <= 0; RegCount <= 0; RegBits <= 0;
	RegFrErr <= 0; RegRxPutData <= 0; RegState <= `SRIDLE;
    end else if(!SClk16) begin // 16 * serial clock
	RegFrErr <= 0; RegRxPutData <= 0;
    end else begin // 16 * serial clock
	case(RegState)
	`SRIDLE: begin
	    if(!RxSData) begin // start bit ??
		RegCount <= 6; // center of the 16 times clock
		RegState <= `SRSTART ;
	    end
	end
	`SRSTART: begin
	    if(NzCount) begin
		RegCount <= DeclCount; // --count
	    end else if(RxSData) begin // the signal was noise
		RegCount <= 0; RegState <= `SRIDLE;
	    end else begin
		RegCount <= 15; RegBits <= 7; 
		RegRxShiftReg <= 0; 
		RegState <= `SRRECV;
	    end
	end
	`SRRECV: begin	
	    if(NzCount) begin
		RegCount <= DeclCount; // --count
	    end else begin	
		RegCount <= 15;
		RegRxShiftReg[7:0] <= {RxSData, RegRxShiftReg[7:1]};
		if((|RegBits)) begin //
		    RegBits <= RegBits - 1; // next bit
		end else begin // done
		    RegState <= `SRSTOP;
		end
	    end
	end
	`SRSTOP: begin
	    if(NzCount) begin
		RegCount <= DeclCount; // --count
	    end else begin	
		RegFrErr <= !RxSData; // stop bit
		RegRxPutData <= 1'b1;
		RegState <= `SRIDLE;
	    end	    
	end
	endcase
    end // if(!Reset_)
    end // always @(posedge RxClk16
endmodule // receive data

// 16 byte length FIFO
`define SERFIFOMAX 15
`define SERFIFOBUS 3:0
`define SERFIFOTOP 4
module SerialFIFO(
    input wire		Clear,
    input wire		Clk,
    input wire		PutEnable,
    input wire [7:0]	PutData,
    input wire		GetEnable,
    output wire [7:0]	GetData,
    output wire		Empty,
    output wire		Full
);
    reg [7:0] RegFIFO [`SERFIFOMAX:0];
    reg [`SERFIFOTOP:0]	RegGetP, RegPutP; // x[4] means wrap around bit
    wire EqualP = (RegPutP[`SERFIFOBUS] == RegGetP[`SERFIFOBUS]);
    wire WrapP = RegGetP[`SERFIFOTOP] ^ RegPutP[`SERFIFOTOP];
    assign Empty = EqualP && !WrapP;
    assign Full  = EqualP &&  WrapP;
    integer i;
    assign GetData[7:0] = RegFIFO[RegGetP[`SERFIFOBUS]];
    // Put side
    always @(posedge Clk or posedge Clear) begin
    if(Clear) begin
	RegPutP <= 0; RegGetP <= 0;
	for(i=0;i<`SERFIFOMAX+1;i=i+1) RegFIFO[i] <= 0;
    end else begin
	if(PutEnable && !Full) begin
	    RegFIFO[RegPutP[`SERFIFOBUS]] <= PutData[7:0];
	    RegPutP[`SERFIFOTOP:0] <= RegPutP[`SERFIFOTOP:0] + 1;
	end
	if(GetEnable && !Empty) begin
	    RegGetP[`SERFIFOTOP:0] <= RegGetP[`SERFIFOTOP:0] + 1;
	end
    end // if(Clear)
    end // always
endmodule

module SerialClockDivider(
    input wire		Clk,
    input wire		Reset_,
    output wire		SClk16 	// 16 times SClk for Rx. one shot, not 50% duty
);
    reg [`DIVBUS] RegCount16;
    assign SClk16 = ~(|RegCount16);
	 
    always @(posedge Clk or negedge Reset_) begin
    if(!Reset_) begin
	RegCount16 <= `DIVCLOCK;
    end else if(SClk16) begin
        RegCount16 <= `DIVCLOCK;
    end else begin 
	RegCount16 <= RegCount16 - 1;
    end 
    end // always @(posedge Clk
endmodule
