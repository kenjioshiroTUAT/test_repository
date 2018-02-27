// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
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

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_BusController16_1_0 (
  Clk,
  CoreClk,
  Reset_,
  Strobe,
  Write,
  Block,
  ByteEnable,
  OutDA,
  Ready,
  InD,
  Interrupt,
  AXIClock,
  AXIARValid,
  AXIARReady,
  AXIARAddr,
  AXIARLen,
  AXIARSize,
  AXIARBurst,
  AXIRValid,
  AXIRReady,
  AXIRLast,
  AXIRData,
  AXIRResp,
  AXIAWValid,
  AXIAWReady,
  AXIAWAddr,
  AXIAWLen,
  AXIAWSize,
  AXIAWBurst,
  AXIWValid,
  AXIWReady,
  AXIWLast,
  AXIWData,
  AXIWStrb,
  AXIBValid,
  AXIBReady,
  AXIBResp,
  reset_n,
  cache_en,
  tlb_en,
  bus_err,
  nmi_n,
  hard_int
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 Clk CLK" *)
input wire Clk;
input wire CoreClk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 Reset_ RST" *)
input wire Reset_;
input wire Strobe;
input wire Write;
input wire Block;
input wire [3 : 0] ByteEnable;
input wire [15 : 0] OutDA;
output wire Ready;
output wire [15 : 0] InD;
output wire Interrupt;
input wire AXIClock;
output wire AXIARValid;
input wire AXIARReady;
output wire [31 : 0] AXIARAddr;
output wire [3 : 0] AXIARLen;
output wire [2 : 0] AXIARSize;
output wire [1 : 0] AXIARBurst;
input wire AXIRValid;
output wire AXIRReady;
input wire AXIRLast;
input wire [31 : 0] AXIRData;
input wire [1 : 0] AXIRResp;
output wire AXIAWValid;
input wire AXIAWReady;
output wire [31 : 0] AXIAWAddr;
output wire [3 : 0] AXIAWLen;
output wire [2 : 0] AXIAWSize;
output wire [1 : 0] AXIAWBurst;
output wire AXIWValid;
input wire AXIWReady;
output wire AXIWLast;
output wire [31 : 0] AXIWData;
output wire [3 : 0] AXIWStrb;
input wire AXIBValid;
output wire AXIBReady;
input wire [1 : 0] AXIBResp;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_n RST" *)
output wire reset_n;
output wire cache_en;
output wire tlb_en;
output wire bus_err;
output wire nmi_n;
output wire hard_int;

  BusController16 inst (
    .Clk(Clk),
    .CoreClk(CoreClk),
    .Reset_(Reset_),
    .Strobe(Strobe),
    .Write(Write),
    .Block(Block),
    .ByteEnable(ByteEnable),
    .OutDA(OutDA),
    .Ready(Ready),
    .InD(InD),
    .Interrupt(Interrupt),
    .AXIClock(AXIClock),
    .AXIARValid(AXIARValid),
    .AXIARReady(AXIARReady),
    .AXIARAddr(AXIARAddr),
    .AXIARLen(AXIARLen),
    .AXIARSize(AXIARSize),
    .AXIARBurst(AXIARBurst),
    .AXIRValid(AXIRValid),
    .AXIRReady(AXIRReady),
    .AXIRLast(AXIRLast),
    .AXIRData(AXIRData),
    .AXIRResp(AXIRResp),
    .AXIAWValid(AXIAWValid),
    .AXIAWReady(AXIAWReady),
    .AXIAWAddr(AXIAWAddr),
    .AXIAWLen(AXIAWLen),
    .AXIAWSize(AXIAWSize),
    .AXIAWBurst(AXIAWBurst),
    .AXIWValid(AXIWValid),
    .AXIWReady(AXIWReady),
    .AXIWLast(AXIWLast),
    .AXIWData(AXIWData),
    .AXIWStrb(AXIWStrb),
    .AXIBValid(AXIBValid),
    .AXIBReady(AXIBReady),
    .AXIBResp(AXIBResp),
    .reset_n(reset_n),
    .cache_en(cache_en),
    .tlb_en(tlb_en),
    .bus_err(bus_err),
    .nmi_n(nmi_n),
    .hard_int(hard_int)
  );
endmodule
