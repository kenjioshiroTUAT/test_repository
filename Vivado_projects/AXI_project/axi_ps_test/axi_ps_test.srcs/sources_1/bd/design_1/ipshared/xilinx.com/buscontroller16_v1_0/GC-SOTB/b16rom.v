//
// 2012-11-25 MN
// simple memory for test of BusCon32
//
module B16BootROM(
    input wire		Clock,
    input wire		Reset_,
    input wire		Strobe,
    input wire [31:0]	Address,
    input wire		R_W,
    input wire [1:0]	ByteEn,
    input wire		OEn,
    input wire		WEn,
    input wire [15:0]	WrData,
    output wire [15:0]	RdData
);

    reg [15:0] Memory [0:1024];
    wire [15:0] OutData;    
    wire [15:0] WriteData;
    wire [9:1] MemAddr = Address[10:1];
    reg [1:0] RegState, NextState;

    assign RdData[15:0] = !OEn ? 16'b0 : OutData;
    assign OutData[15:0] = Memory[MemAddr];
    assign WriteData[15:0] = {ByteEn[1] ? WrData[15:8] : OutData[15:8],
                        ByteEn[0] ? WrData[7:0] : OutData[7:0]};
    integer i;
	initial begin
	for(i = 0; i < 1024; i = i + 1)	Memory[i] = 0;
	$readmemh("btst.dat",Memory);
	end
	
	
    always @(posedge Clock or negedge Reset_) begin
    if(!Reset_) begin
	    //RegState <= 0;
	end else begin
	    if(WEn) begin
		  Memory[MemAddr] <= WriteData;
	    end
	    //RegState <= NextState;
	end
    end  //always
endmodule
