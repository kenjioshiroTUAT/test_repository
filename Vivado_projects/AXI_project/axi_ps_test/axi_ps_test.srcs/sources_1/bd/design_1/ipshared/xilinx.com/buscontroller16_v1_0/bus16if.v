//
// never write state transition under lower modules
// BC16xxxx, AXIxxxx, IORxxxx, CTLxxxx
// for Buscon16
// 2017-10-23,24, 11-03 MN
//

`define IDLE   4'b0000
`define REXEC  4'b0001
`define RRDY   4'b0010
`define RTRANS 4'b0011
`define RBERR  4'b0111
`define WRDY   4'b1000
`define WTRANS 4'b1001
`define WKICK  4'b1010
`define WEXEC  4'b1011

module BUS16CONTROL (
  input wire	    BC16Clock,
  input wire	    Reset_,
  input wire	    BC16Strobe,
  input wire	    BC16Write,
  input wire	    BC16Last,
  output reg	    BC16Ready,
  output reg	    BC16BErr,
  output reg	    CTLStart, CTLEnd,
  output reg	    CTLExec,
  input wire	    CTLReady, // read: ready, write:done
  input wire	    CTLBErr
) ;
  reg [3:0]	State;
  reg [3:0]	RegState;

  always @(*) begin
    State = RegState;
    BC16Ready = 1'b0; BC16BErr = 1'b0;
    CTLStart = 1'b0; CTLEnd = 1'b0; CTLExec = 1'b0;
    case (RegState)
    `IDLE: begin
        if(BC16Strobe) begin
	    CTLStart = 1'b1;
            if(BC16Write)
	        State = `WRDY;
	    else
	        State = `REXEC;
	end
    end
    //----
    `REXEC: begin
        CTLExec = 1'b1;
	if(CTLBErr) State = `RBERR;
	else if(CTLReady) State = `RRDY;
    end
    `RRDY: begin
        BC16Ready = 1'b1;
	if(BC16Last) begin
	    CTLEnd = 1'b1;
            State = `IDLE;
	end else
            State = `RTRANS;
    end
    `RTRANS: begin
	if(BC16Last) begin
	    CTLEnd = 1'b1;
            State = `IDLE;
	end
    end
    `RBERR: begin
        BC16Ready = 1'b1; BC16BErr = 1'b1;
	CTLEnd = 1'b1;
	State = `IDLE;
    end
    //----
    `WRDY: begin
        BC16Ready = 1'b1;
        State = `WTRANS;
    end
    `WTRANS: begin
	if(BC16Last) State = `WKICK;
    end
    `WKICK: begin
        CTLExec = 1'b1;
	State = `WEXEC;
    end
    `WEXEC: begin
        CTLExec = 1'b1;
	if(CTLReady || CTLBErr) begin
	    CTLEnd = 1'b1;
            State = `IDLE;
	end
    end
    endcase
  end // always(*)

  always @(posedge BC16Clock or negedge Reset_) begin
    if(! Reset_) begin
       RegState <= `IDLE;
    end else begin
       RegState <= State;
    end
  end //always(posedge Clock 

endmodule
