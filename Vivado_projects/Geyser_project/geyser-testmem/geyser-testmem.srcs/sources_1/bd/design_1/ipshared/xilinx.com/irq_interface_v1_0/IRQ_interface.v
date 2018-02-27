`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/17 15:15:48
// Design Name: 
// Module Name: Bram_Interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Bram_Interface(
       //Geyser Interface
    input wire Clock,
    input wire [31:0]Address,
    input wire [1:0]ByteEn,
    input wire OEn,
    input wire WEn,
    input wire [15:0]WrData,
    input wire Strobe,
    output wire [15:0]RdData,
    
    //Bram Interface
    output wire [12:0]bram_addr,  //Bram address 13bit
    output wire clk,             //Bram clock
    output wire [15:0]din,       //Bram input data 16bit
    input wire [15:0]dout,       //bram output data 16bit
    output wire en,              //bram port enable
    output wire we,              //bram write enable
    output reg irq              //irq
    );
    reg [14:0] count;
    initial begin
        irq = 0;
    end
    wire [15:0] OutData;    
    wire [15:0] WriteData;
    
    assign clk = Clock;
    assign bram_addr[12:0] = Address[13:1];
    assign en = Strobe;
    assign we = WEn;
    assign din[15:0] = WriteData;
    assign OutData[15:0] = dout;
    assign RdData[15:0] = !OEn ? 16'b0 : OutData;
    assign WriteData[15:0] = {ByteEn[1] ? WrData[15:8] : OutData[15:8],
                            ByteEn[0] ? WrData[7:0] : OutData[7:0]};
                            
    always@(posedge Clock)begin
        if(Address == 32'hBFC0_0000)begin
            irq <= 1;
            count <= 0;
        end
        if(irq)begin
            count <= count + 1;
        end
        if(&count)begin
            irq <= 0;
        end
    end 
    
    always@(posedge Clock)begin
        
    end
    
    
    
endmodule
