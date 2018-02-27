//
// never write state transition under lower modules
// BC16xxxx, AXIxxxx, IORxxxx, CTLxxxx
// for AXI3(32)Buscon16
// 2017-10-24, 11-03,04,22 MN
//

`define IDLE   4'b0000
`define REXEC  4'b0001
`define RTRANS 4'b0010
`define RBERR  4'b0111
`define WEXEC  4'b1000
`define WTRANS 4'b1001
`define WCHECK 4'b1010
`define WBERR  4'b1100
`define DONE   4'b1110
`define UNDEF  4'b1111

module AXI32CONTROL (
  input wire	AXIClock,
  input wire	Reset_,
  //----
  output reg	AXIARValid,
  input wire	AXIARReady,
  input wire	AXIRValid,
  input wire	AXIRLast,
  output reg	AXIRReady,
  input wire [1:0] AXIRResp,
  //----
  output reg	AXIAWValid,
  input wire	AXIAWReady,
  output reg	AXIWValid,
  input wire	AXIWReady,
  output reg	AXIWLast,
  input wire	AXIBValid,
  output reg	AXIBReady,
  input wire [1:0] AXIBResp,
  //----
  input wire	CTLWrite,
  output reg	CTLStart, CTLEnd,
  input wire	CTLExec,
  output reg	CTLReady, // read: ready, write:done
  output reg	CTLPutEn, CTLGetEn,
  input wire	CTLWLast,
  output reg	CTLRBErr,
  output reg    CTLWBErr
) ;
  reg [3:0]	State;
  reg [3:0]	RegState;
  wire RErr = (AXIRResp == 2'b10 || AXIRResp == 2'b11);
  wire WErr = (AXIBResp == 2'b10 || AXIBResp == 2'b11);

  always @(*) begin
    State = RegState;
    AXIARValid = 1'b0; AXIRReady = 1'b0;
    AXIAWValid = 1'b0; AXIWValid = 1'b0; AXIWLast = 1'b0; AXIBReady = 1'b0;
    CTLStart = 1'b0; CTLEnd = 1'b0; CTLReady = 1'b0;
    CTLPutEn = 1'b0; CTLGetEn = 1'b0;
    CTLRBErr = 1'b0; CTLWBErr = 1'b0;
    case (RegState)
    `IDLE: begin
        if(CTLExec) begin
	    CTLStart = 1'b1;
            State = CTLWrite ? `WEXEC : `REXEC;
	end
    end
    //----
    `REXEC: begin
        AXIARValid = 1'b1;
	AXIRReady = 1'b1;
	if(AXIRValid) begin
	    if(RErr) begin
	        State = `RBERR;
	    end else begin
	        CTLPutEn = 1'b1;
	        if(AXIRLast) begin
		    CTLReady = 1'b1;
		    State = `DONE;
		end else begin
		    State = `RTRANS;
		end
	    end
	end else if(AXIARReady) begin
	    State = `RTRANS;
	end
    end
    `RTRANS: begin
	AXIRReady = 1'b1;
	if(AXIRValid) begin
	    if(RErr) begin
	        State = `RBERR;
	    end else begin
	        CTLPutEn = 1'b1;
	        if(AXIRLast) begin
		    CTLReady = 1'b1;
		    State = `DONE;
		end
	    end
        end
    end
    `RBERR: begin
        if(CTLExec) begin
	    CTLRBErr = 1'b1;
	    CTLReady = 1'b1;
	end else begin
            CTLEnd = 1'b1;
	    State = `IDLE;
	end
    end
    //---- 
    `WEXEC: begin
        AXIAWValid = 1'b1;
	if(AXIWReady) begin
	    AXIWValid = 1'b1;
	    CTLGetEn = 1'b1;
	    State = CTLWLast? `WCHECK : `WTRANS;
	end else if(AXIAWReady) begin
	    State = `WTRANS;
	end
    end
    `WTRANS: begin
	AXIWValid = 1'b1;
	if(AXIWReady) begin
	    CTLGetEn = 1'b1;
	    if(CTLWLast) begin
	        AXIWLast = 1'b1;
	        State = `WCHECK;
	    end
	end 
    end
    `WCHECK: begin
        AXIBReady = 1'b1;
	if(AXIBValid) begin
	    State = WErr ? `WBERR : `DONE;
	end
    end
    `WBERR: begin
        if(CTLExec) begin
	    CTLWBErr = 1'b1;
	    CTLReady = 1'b1;
	end else begin
            CTLEnd = 1'b1;
	    State = `IDLE;
	end
    end
    `DONE: begin
        if(CTLExec) begin
	    CTLReady = 1'b1;
	end else begin
            CTLEnd = 1'b1;
	    State = `IDLE;
	end
    end
    default: State = `UNDEF;
    endcase
  end // always(*)

  always @(posedge AXIClock or negedge Reset_) begin
    if(! Reset_) begin
       RegState <= `IDLE;
    end else begin
       RegState <= State;
    end
  end //always(posedge AXIClock 

endmodule
