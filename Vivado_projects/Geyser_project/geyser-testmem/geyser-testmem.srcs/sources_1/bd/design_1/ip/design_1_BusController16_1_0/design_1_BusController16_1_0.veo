// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:user:BusController16:1.0
// IP Revision: 2

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
design_1_BusController16_1_0 your_instance_name (
  .Clk(Clk),                              // input wire Clk
  .CoreClk(CoreClk),                      // input wire CoreClk
  .Reset_(Reset_),                        // input wire Reset_
  .Strobe(Strobe),                        // input wire Strobe
  .Write(Write),                          // input wire Write
  .Block(Block),                          // input wire Block
  .ByteEnable(ByteEnable),                // input wire [3 : 0] ByteEnable
  .OutDA(OutDA),                          // input wire [15 : 0] OutDA
  .Ready(Ready),                          // output wire Ready
  .InD(InD),                              // output wire [15 : 0] InD
  .Interrupt(Interrupt),                  // output wire Interrupt
  .UARTRxData(UARTRxData),                // input wire UARTRxData
  .UARTTxData(UARTTxData),                // output wire UARTTxData
  .reset_n(reset_n),                      // output wire reset_n
  .cache_en(cache_en),                    // output wire cache_en
  .tlb_en(tlb_en),                        // output wire tlb_en
  .bus_err(bus_err),                      // output wire bus_err
  .nmi_n(nmi_n),                          // output wire nmi_n
  .hard_int(hard_int),                    // output wire hard_int
  .rom_addr(rom_addr),                    // output wire [31 : 0] rom_addr
  .rom_ByteEnable(rom_ByteEnable),        // output wire [1 : 0] rom_ByteEnable
  .rom_OEn(rom_OEn),                      // output wire rom_OEn
  .rom_WEn(rom_WEn),                      // output wire rom_WEn
  .rom_WrData(rom_WrData),                // output wire [15 : 0] rom_WrData
  .rom_en(rom_en),                        // output wire rom_en
  .rom_RdData(rom_RdData),                // input wire [15 : 0] rom_RdData
  .ram_addr(ram_addr),                    // output wire [31 : 0] ram_addr
  .ram_ByteEnable(ram_ByteEnable),        // output wire [1 : 0] ram_ByteEnable
  .ram_OEn(ram_OEn),                      // output wire ram_OEn
  .ram_WEn(ram_WEn),                      // output wire ram_WEn
  .ram_WrData(ram_WrData),                // output wire [15 : 0] ram_WrData
  .ram_en(ram_en),                        // output wire ram_en
  .ram_RdData(ram_RdData),                // input wire [15 : 0] ram_RdData
  .shared_addr(shared_addr),              // output wire [31 : 0] shared_addr
  .shared_ByteEnable(shared_ByteEnable),  // output wire [1 : 0] shared_ByteEnable
  .shared_OEn(shared_OEn),                // output wire shared_OEn
  .shared_WEn(shared_WEn),                // output wire shared_WEn
  .shared_WrData(shared_WrData),          // output wire [15 : 0] shared_WrData
  .shared_en(shared_en),                  // output wire shared_en
  .shared_RdData(shared_RdData)          // input wire [15 : 0] shared_RdData
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file design_1_BusController16_1_0.v when simulating
// the core, design_1_BusController16_1_0. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

