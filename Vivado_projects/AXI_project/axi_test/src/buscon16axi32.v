//
// never write state transition under lower modules
// BC16xxxx, AXIxxxx, IORxxxx, CTLxxxx, CFxxxx
// for Buscon16, AXI32
// 2017-10-24, 11-03,04 MN
//
// 2017-12-03 MN for Zynq, Address translation
//

module BUS16AXI32CONTROL(
  input wire	    Reset_,
  input wire	    BC16Clock,
  //--------
  input wire	    BC16Strobe,
  input wire [31:0] BC16Address, //
  input wire [15:0] BC16WrData, //
  output wire [15:0] BC16RdData, //
  input wire	    BC16Write,
  input wire	    BC16Last,
  output wire	    BC16Ready,
  output wire	    BC16BErr,
  input wire	    BC16OEn, BC16WEn, //
  input wire	    BC16Upper, BC16Lower, //
  input wire [3:0]  BC16ByteEn32, //
  input wire [1:0]  BC16Mode, //
  //--------
  input wire	    AXIClock,
  //--
  output wire	    AXIARValid,
  input wire	    AXIARReady,
  output wire [31:0] AXIARAddr, //
  output wire [3:0] AXIARLen,   //
  output wire [2:0] AXIARSize,  //
  output wire [1:0] AXIARBurst, //
  input wire	    AXIRValid,
  output wire	    AXIRReady,
  input wire	    AXIRLast,
  input wire [31:0] AXIRData, //
  input wire [1:0]  AXIRResp,
  //--
  output wire	    AXIAWValid,
  input wire	    AXIAWReady,
  output wire [31:0] AXIAWAddr, //
  output wire [3:0] AXIAWLen,   //
  output wire [2:0] AXIAWSize,  //
  output wire [1:0] AXIAWBurst, //
  output wire	    AXIWValid,
  input wire	    AXIWReady,
  output wire	    AXIWLast,
  output wire [31:0] AXIWData, //
  output wire [3:0] AXIWStrb,  //
  input wire	    AXIBValid,
  output wire	    AXIBReady,
  input wire [1:0]  AXIBResp
); 			 
  // simple address translation (example)
  wire [31:0] TransAddress =
         ((BC16Address[31:20] == 12'h800)
	  || (BC16Address[31:20] == 12'ha00)) ?
	     {12'h300, BC16Address[19:2], 2'b00}
	 : (BC16Address[31:16] == 16'hb880) ?
	     {16'he000, BC16Address[15:0]}
	 : 32'h0000_0000 ; // for safe
  // 
  reg [31:0] RegAddress ;
  reg [3:0]  RegByteEn32;
  reg RegUpper, RegLower, RegBurst, RegWrite;
  wire CTLExec, CTLReady;
  wire CTLRBErr;
  wire CTLStart16,CTLEnd16, CTLStart32, CTLEnd32;
  wire CTLGetEn32, CTLPutEn32, CTLWLast32;
  wire [3:0] AxLen = RegBurst ? 4'd15 : 4'd1;

  assign AXIARAddr = RegAddress;
  assign AXIARLen = AxLen;
  assign AXIARSize = 3'd2; // 32bit
  assign AXIARBurst = 2'b01; // increment
  assign AXIAWAddr = RegAddress;
  assign AXIAWLen = AxLen;
  assign AXIAWSize = 3'd2; // 32bit
  assign AXIAWBurst = 2'b01; // increment
  assign AXIWStrb = RegByteEn32;
  always @(posedge BC16Clock or negedge Reset_) begin
      if(!Reset_) begin
	 RegAddress <= 0; RegByteEn32 <= 0; RegWrite <= 1'b0;
	 RegBurst <= 0; RegUpper <= 0; RegLower <= 0;
      end else if(CTLStart16) begin
//	 RegAddress[31:0] <= {BC16Address[31:2], 2'b0}; translated
	 RegAddress[31:0] <= TransAddress;
	 RegByteEn32[3:0] <= BC16ByteEn32[3:0];
	 RegBurst <= (BC16Mode == 2'b11) ;
	 RegWrite <= BC16Write;
	 RegUpper <= BC16Upper; RegLower <= BC16Lower;
      end
  end

  BUS16CONTROL Bus16Control(
    .BC16Clock(BC16Clock),
    .Reset_(Reset_),
    .BC16Strobe(BC16Strobe),
    .BC16Write(BC16Write),
    .BC16Last(BC16Last),
    .BC16Ready(BC16Ready),
    .BC16BErr(BC16BErr),
    .CTLStart(CTLStart16), .CTLEnd(CTLEnd16),
    .CTLExec(CTLExec),
    .CTLReady(CTLReady), // read: ready, write:done
    .CTLBErr(CTLRBErr)
  );

  AXI32CONTROL AXI32Control(
    .AXIClock(AXIClock),
    .Reset_(Reset_),
    .AXIARValid(AXIARValid),
    .AXIARReady(AXIARReady),
    .AXIRValid(AXIRValid),
    .AXIRLast(AXIRLast),
    .AXIRReady(AXIRReady),
    .AXIRResp(AXIRResp),
    //----
    .AXIAWValid(AXIAWValid),
    .AXIAWReady(AXIAWReady),
    .AXIWValid(AXIWValid),
    .AXIWReady(AXIWReady),
    .AXIWLast(AXIWLast),
    .AXIBValid(AXIBValid),
    .AXIBReady(AXIBReady),
    .AXIBResp(AXIBResp),
    //----
    .CTLWrite(RegWrite),
    .CTLStart(CTLStart32), .CTLEnd(CTLEnd32),
    .CTLExec(CTLExec),
    .CTLReady(CTLReady), // read: ready, write:done
    .CTLPutEn(CTLPutEn32), .CTLGetEn(CTLGetEn32),
    .CTLWLast(CTLWLast32),
    .CTLRBErr(CTLRBErr),
    .CTLWBErr()
  ) ;

  GFIFO16TO32 GWriteFIFO ( // for write  Get:32, Put:16
    .Reset_(Reset_),
    .PutClk(BC16Clock),
    .PutData(BC16WrData),
    .PutEn(BC16WEn),
    .PutU(RegUpper), .PutL(RegLower),
    .PutClr(CTLStart16),
    .GetClk(AXIClock),
    .GetData(AXIWData),
    .GetLast(CTLWLast32), 
    .GetEn(CTLGetEn32),
    .GetClr(CTLStart32)
  ) ;

  GFIFO16FROM32 GReadFIFO( // for read  Get:16(), Put:32
    .Reset_(Reset_),
    .PutClk(AXIClock),
    .PutData(AXIRData),
    .PutEn(CTLPutEn32),
    .PutClr(CTLStart32),
    .GetClk(BC16Clock),
    .GetData(BC16RdData),
    .GetEn(BC16OEn),
    .GetU(RegUpper), .GetL(RegLower),
    .GetClr(CTLStart16)
  ) ;

endmodule //module BUS16AXI32CONTROL(
  
