//
// 2017-10-22,24, 11-01,22,29,30 MN
//

module GFIFO16TO32( // for write
  input wire 	     Reset_,
  input wire 	     PutClk,
  input wire [15:0]  PutData,
  input wire 	     PutEn,
  input wire 	     PutU,PutL,
  input wire 	     PutClr,
  input wire 	     GetClk,
  output wire [31:0] GetData,
  output wire        GetLast, 	     
  input wire 	     GetEn,
  input wire 	     GetClr
) ;
  reg [15:0]	FifoU [15:0], FifoL[15:0];
  reg [5:0]	PutP;
  reg [3:0]	GetP;
  assign	GetData = {FifoU[GetP[3:0]], FifoL[GetP[3:0]]};
  assign        GetLast = ! GetEn ? 1'b0
  			  : PutP[5] ? (GetP == 4'd15) : (GetP == 4'd0);

  always @(posedge PutClk or negedge Reset_)  begin
    if(! Reset_) begin
        PutP <= 6'b0;
    end else if(PutClr) begin
    	PutP <= 6'b0;
    end else if(PutEn) begin
        if(PutU) begin
	    FifoU[0] <= PutData[15:0]; FifoL[0] <= 16'b0;
 	    PutP <= 6'd2;
	end else if(PutL) begin
	    FifoU[0] <= 16'b0; FifoL[0] <= PutData[15:0];
 	    PutP <= 6'd2;
	end else begin
	    if(PutP[0])
		FifoU[PutP[4:1]] <= PutData[15:0];
	    else
		FifoL[PutP[4:1]] <= PutData[15:0];
	    PutP[5:0] <= PutP[5:0] + 6'b1;
	end
    end
  end //  always(posedge PutClk or negedge Reset_)
  always @(posedge GetClk or negedge Reset_) begin
    if(! Reset_) begin
        GetP <= 4'b0;
    end else if(GetClr) begin
    	GetP <= 4'b0;
    end else if(GetEn) begin
        GetP[3:0] <= GetP[3:0] + 4'b1;
    end
  end //  always(posedge GetClk or negedge Reset_)
endmodule
 
module GFIFO16FROM32( // for read
  input wire	  	Reset_,
  input wire		PutClk,
  input wire [31:0]	PutData,
  input wire 		PutEn,
  input wire		PutClr,
  input wire		GetClk,
  output wire [15:0]	GetData,
  input wire 		GetEn,
  input wire 		GetU,GetL,
  input wire		GetClr
) ;
  reg [15:0]	FifoU [15:0], FifoL[15:0];
  reg [3:0]	PutP;
  reg [4:0]	GetP;
  assign	GetData = GetU ? FifoU[0]
			  : GetL ? FifoL[0]
			  : GetP[0] ? FifoU[GetP[4:1]]
			  : FifoL[GetP[4:1]] ;
  always @(posedge PutClk or negedge Reset_) begin
    if(! Reset_) begin
        PutP <= 4'b0;
    end else if(PutClr) begin
    	PutP <= 4'b0;
    end else if(PutEn) begin
        {FifoU[PutP[3:0]], FifoL[PutP[3:0]]} <= PutData[31:0];
        PutP[3:0] <= PutP[3:0] + 4'b1;
    end
  end //  always(posedge GetClk or negedge Reset_)
  always @(posedge GetClk or negedge Reset_) begin
    if(! Reset_) begin
        GetP <= 5'b0;
    end else if(GetClr) begin
    	GetP <= 5'b0;
    end else if(GetEn) begin
        if(GetU || GetL)
 	    GetP <= 5'd2;
	else
	    GetP[4:0] <= GetP[4:0] + 5'b1;
    end
  end //  always(posedge GetClk or negedge Reset_)

endmodule
 
