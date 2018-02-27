-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:user:BusController16:1.0
-- IP Revision: 2

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT design_1_BusController16_1_0
  PORT (
    Clk : IN STD_LOGIC;
    CoreClk : IN STD_LOGIC;
    Reset_ : IN STD_LOGIC;
    Strobe : IN STD_LOGIC;
    Write : IN STD_LOGIC;
    Block : IN STD_LOGIC;
    ByteEnable : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    OutDA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    Ready : OUT STD_LOGIC;
    InD : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    Interrupt : OUT STD_LOGIC;
    AXIClock : IN STD_LOGIC;
    AXIARValid : OUT STD_LOGIC;
    AXIARReady : IN STD_LOGIC;
    AXIARAddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    AXIARLen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    AXIARSize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    AXIARBurst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    AXIRValid : IN STD_LOGIC;
    AXIRReady : OUT STD_LOGIC;
    AXIRLast : IN STD_LOGIC;
    AXIRData : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    AXIRResp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    AXIAWValid : OUT STD_LOGIC;
    AXIAWReady : IN STD_LOGIC;
    AXIAWAddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    AXIAWLen : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    AXIAWSize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    AXIAWBurst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    AXIWValid : OUT STD_LOGIC;
    AXIWReady : IN STD_LOGIC;
    AXIWLast : OUT STD_LOGIC;
    AXIWData : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    AXIWStrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    AXIBValid : IN STD_LOGIC;
    AXIBReady : OUT STD_LOGIC;
    AXIBResp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    reset_n : OUT STD_LOGIC;
    cache_en : OUT STD_LOGIC;
    tlb_en : OUT STD_LOGIC;
    bus_err : OUT STD_LOGIC;
    nmi_n : OUT STD_LOGIC;
    hard_int : OUT STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : design_1_BusController16_1_0
  PORT MAP (
    Clk => Clk,
    CoreClk => CoreClk,
    Reset_ => Reset_,
    Strobe => Strobe,
    Write => Write,
    Block => Block,
    ByteEnable => ByteEnable,
    OutDA => OutDA,
    Ready => Ready,
    InD => InD,
    Interrupt => Interrupt,
    AXIClock => AXIClock,
    AXIARValid => AXIARValid,
    AXIARReady => AXIARReady,
    AXIARAddr => AXIARAddr,
    AXIARLen => AXIARLen,
    AXIARSize => AXIARSize,
    AXIARBurst => AXIARBurst,
    AXIRValid => AXIRValid,
    AXIRReady => AXIRReady,
    AXIRLast => AXIRLast,
    AXIRData => AXIRData,
    AXIRResp => AXIRResp,
    AXIAWValid => AXIAWValid,
    AXIAWReady => AXIAWReady,
    AXIAWAddr => AXIAWAddr,
    AXIAWLen => AXIAWLen,
    AXIAWSize => AXIAWSize,
    AXIAWBurst => AXIAWBurst,
    AXIWValid => AXIWValid,
    AXIWReady => AXIWReady,
    AXIWLast => AXIWLast,
    AXIWData => AXIWData,
    AXIWStrb => AXIWStrb,
    AXIBValid => AXIBValid,
    AXIBReady => AXIBReady,
    AXIBResp => AXIBResp,
    reset_n => reset_n,
    cache_en => cache_en,
    tlb_en => tlb_en,
    bus_err => bus_err,
    nmi_n => nmi_n,
    hard_int => hard_int
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file design_1_BusController16_1_0.vhd when simulating
-- the core, design_1_BusController16_1_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

