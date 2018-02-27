`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/01 21:19:45
// Design Name: 
// Module Name: ip_disabling_byte_addressing
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


module trans_addr_12to11(
    input [12:0] axi_bram_ctrl_addr,
    output [11:0] my_bram_addr
    );
    assign my_bram_addr = axi_bram_ctrl_addr[12:1];
endmodule
