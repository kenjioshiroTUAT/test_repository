
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg400-1
#    set_property BOARD_PART em.avnet.com:microzed_7020:part0:1.1 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set Blk [ create_bd_port -dir I Blk ]
  set ByteEn [ create_bd_port -dir I -from 3 -to 0 ByteEn ]
  set In_Da [ create_bd_port -dir O -from 15 -to 0 In_Da ]
  set Out_Da [ create_bd_port -dir I -from 15 -to 0 Out_Da ]
  set Ready [ create_bd_port -dir O Ready ]
  set Strobe [ create_bd_port -dir I Strobe ]
  set Write [ create_bd_port -dir I Write ]
  set bus_err [ create_bd_port -dir O bus_err ]
  set cache_en [ create_bd_port -dir O cache_en ]
  set clk_0 [ create_bd_port -dir O clk_0 ]
  set clk_1 [ create_bd_port -dir O -type clk clk_1 ]
  set hard_int [ create_bd_port -dir O hard_int ]
  set nmi_n [ create_bd_port -dir O nmi_n ]
  set reset_n [ create_bd_port -dir O reset_n ]
  set tlb_en [ create_bd_port -dir O tlb_en ]

  # Create instance: BusController16_1, and set properties
  set BusController16_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:BusController16:1.0 BusController16_1 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_DOUT_DEFAULT {0x00000001} \
CONFIG.C_GPIO_WIDTH {1} \
 ] $axi_gpio_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Write_Depth_A {8192} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_DRIVES {BUFG} \
CONFIG.CLKOUT1_JITTER {325.072} \
CONFIG.CLKOUT1_PHASE_ERROR {300.046} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {15.000} \
CONFIG.CLKOUT2_DRIVES {BUFG} \
CONFIG.CLKOUT2_JITTER {284.425} \
CONFIG.CLKOUT2_PHASE_ERROR {300.046} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {30.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_DRIVES {BUFG} \
CONFIG.CLKOUT3_JITTER {254.384} \
CONFIG.CLKOUT3_PHASE_ERROR {300.046} \
CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {60.000} \
CONFIG.CLKOUT3_USED {true} \
CONFIG.CLKOUT4_DRIVES {BUFG} \
CONFIG.CLKOUT5_DRIVES {BUFG} \
CONFIG.CLKOUT6_DRIVES {BUFG} \
CONFIG.CLKOUT7_DRIVES {BUFG} \
CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
CONFIG.MMCM_CLKFBOUT_MULT_F {51.000} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {68.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {34} \
CONFIG.MMCM_CLKOUT2_DIVIDE {17} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {5} \
CONFIG.NUM_OUT_CLKS {3} \
CONFIG.PRIMITIVE {MMCM} \
CONFIG.USE_DYN_RECONFIG {true} \
 ] $clk_wiz_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_0 ]
  set_property -dict [ list \
CONFIG.C_DATA_DEPTH {8192} \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {30} \
CONFIG.C_PROBE0_WIDTH {16} \
CONFIG.C_PROBE10_WIDTH {3} \
CONFIG.C_PROBE14_WIDTH {2} \
CONFIG.C_PROBE15_WIDTH {32} \
CONFIG.C_PROBE16_WIDTH {32} \
CONFIG.C_PROBE19_WIDTH {2} \
CONFIG.C_PROBE1_WIDTH {16} \
CONFIG.C_PROBE20_WIDTH {4} \
CONFIG.C_PROBE21_WIDTH {3} \
CONFIG.C_PROBE23_WIDTH {4} \
CONFIG.C_PROBE25_WIDTH {32} \
CONFIG.C_PROBE27_WIDTH {2} \
CONFIG.C_PROBE6_WIDTH {32} \
CONFIG.C_PROBE9_WIDTH {4} \
 ] $ila_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {0} \
CONFIG.PCW_EN_CLK2_PORT {0} \
CONFIG.PCW_EN_CLK3_PORT {0} \
CONFIG.PCW_EN_DDR {1} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {0} \
CONFIG.PCW_EN_RST2_PORT {0} \
CONFIG.PCW_EN_RST3_PORT {0} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK_CLK0_BUF {true} \
CONFIG.PCW_FCLK_CLK1_BUF {false} \
CONFIG.PCW_FCLK_CLK2_BUF {false} \
CONFIG.PCW_FCLK_CLK3_BUF {false} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {33.333333} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_MIO_0_PULLUP {disabled} \
CONFIG.PCW_MIO_0_SLEW {slow} \
CONFIG.PCW_MIO_10_PULLUP {disabled} \
CONFIG.PCW_MIO_10_SLEW {slow} \
CONFIG.PCW_MIO_11_PULLUP {disabled} \
CONFIG.PCW_MIO_11_SLEW {slow} \
CONFIG.PCW_MIO_12_PULLUP {disabled} \
CONFIG.PCW_MIO_12_SLEW {slow} \
CONFIG.PCW_MIO_13_PULLUP {disabled} \
CONFIG.PCW_MIO_13_SLEW {slow} \
CONFIG.PCW_MIO_14_PULLUP {disabled} \
CONFIG.PCW_MIO_14_SLEW {slow} \
CONFIG.PCW_MIO_15_PULLUP {disabled} \
CONFIG.PCW_MIO_15_SLEW {slow} \
CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {slow} \
CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {slow} \
CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {slow} \
CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {slow} \
CONFIG.PCW_MIO_1_PULLUP {disabled} \
CONFIG.PCW_MIO_1_SLEW {slow} \
CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {slow} \
CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {slow} \
CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {slow} \
CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {slow} \
CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {slow} \
CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {slow} \
CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {slow} \
CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {slow} \
CONFIG.PCW_MIO_28_PULLUP {disabled} \
CONFIG.PCW_MIO_28_SLEW {slow} \
CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_29_SLEW {slow} \
CONFIG.PCW_MIO_2_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {slow} \
CONFIG.PCW_MIO_30_PULLUP {disabled} \
CONFIG.PCW_MIO_30_SLEW {slow} \
CONFIG.PCW_MIO_31_PULLUP {disabled} \
CONFIG.PCW_MIO_31_SLEW {slow} \
CONFIG.PCW_MIO_32_PULLUP {disabled} \
CONFIG.PCW_MIO_32_SLEW {slow} \
CONFIG.PCW_MIO_33_PULLUP {disabled} \
CONFIG.PCW_MIO_33_SLEW {slow} \
CONFIG.PCW_MIO_34_PULLUP {disabled} \
CONFIG.PCW_MIO_34_SLEW {slow} \
CONFIG.PCW_MIO_35_PULLUP {disabled} \
CONFIG.PCW_MIO_35_SLEW {slow} \
CONFIG.PCW_MIO_36_PULLUP {disabled} \
CONFIG.PCW_MIO_36_SLEW {slow} \
CONFIG.PCW_MIO_37_PULLUP {disabled} \
CONFIG.PCW_MIO_37_SLEW {slow} \
CONFIG.PCW_MIO_38_PULLUP {disabled} \
CONFIG.PCW_MIO_38_SLEW {slow} \
CONFIG.PCW_MIO_39_PULLUP {disabled} \
CONFIG.PCW_MIO_39_SLEW {slow} \
CONFIG.PCW_MIO_3_PULLUP {disabled} \
CONFIG.PCW_MIO_3_SLEW {slow} \
CONFIG.PCW_MIO_40_PULLUP {disabled} \
CONFIG.PCW_MIO_40_SLEW {slow} \
CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_41_SLEW {slow} \
CONFIG.PCW_MIO_42_PULLUP {disabled} \
CONFIG.PCW_MIO_42_SLEW {slow} \
CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_43_SLEW {slow} \
CONFIG.PCW_MIO_44_PULLUP {disabled} \
CONFIG.PCW_MIO_44_SLEW {slow} \
CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_45_SLEW {slow} \
CONFIG.PCW_MIO_46_PULLUP {disabled} \
CONFIG.PCW_MIO_46_SLEW {slow} \
CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_47_SLEW {slow} \
CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_48_SLEW {slow} \
CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_49_SLEW {slow} \
CONFIG.PCW_MIO_4_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {slow} \
CONFIG.PCW_MIO_50_PULLUP {disabled} \
CONFIG.PCW_MIO_50_SLEW {slow} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_MIO_51_SLEW {slow} \
CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_PULLUP {disabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_PULLUP {disabled} \
CONFIG.PCW_MIO_5_SLEW {slow} \
CONFIG.PCW_MIO_6_PULLUP {disabled} \
CONFIG.PCW_MIO_6_SLEW {slow} \
CONFIG.PCW_MIO_7_PULLUP {disabled} \
CONFIG.PCW_MIO_7_SLEW {slow} \
CONFIG.PCW_MIO_8_PULLUP {disabled} \
CONFIG.PCW_MIO_8_SLEW {slow} \
CONFIG.PCW_MIO_9_PULLUP {disabled} \
CONFIG.PCW_MIO_9_SLEW {slow} \
CONFIG.PCW_PACKAGE_NAME {clg400} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 46} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_SD0_GRP_WP_IO {MIO 50} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {111.111115} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UIPARAM_ACT_DDR_FREQ_MHZ {533.333374} \
CONFIG.PCW_UIPARAM_DDR_BL {8} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.294} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.298} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.338} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.334} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {39.7} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {39.7} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {54.14} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {54.14} \
CONFIG.PCW_UIPARAM_DDR_CWL {6} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {50.05} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {50.43} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {50.10} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {50.01} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.073} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.072} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {0.024} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {0.023} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {49.59} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {51.74} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {50.32} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {48.55} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB0_RESET_ENABLE {1} \
CONFIG.PCW_USB0_RESET_IO {MIO 7} \
CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_M_AXI_GP1 {0} \
CONFIG.PCW_USE_S_AXI_GP0 {1} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {3} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins clk_wiz_0/s_axi_lite] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]

  # Create port connections
  connect_bd_net -net Blk_1 [get_bd_ports Blk] [get_bd_pins BusController16_1/Block] [get_bd_pins ila_0/probe5]
  connect_bd_net -net BusController16_0_AXIARAddr [get_bd_pins BusController16_1/AXIARAddr] [get_bd_pins ila_0/probe6] [get_bd_pins processing_system7_0/S_AXI_GP0_ARADDR]
  connect_bd_net -net BusController16_0_AXIARLen [get_bd_pins BusController16_1/AXIARLen] [get_bd_pins ila_0/probe9] [get_bd_pins processing_system7_0/S_AXI_GP0_ARLEN]
  connect_bd_net -net BusController16_0_AXIARSize [get_bd_pins BusController16_1/AXIARSize] [get_bd_pins ila_0/probe10] [get_bd_pins processing_system7_0/S_AXI_GP0_ARSIZE]
  connect_bd_net -net BusController16_0_AXIARValid [get_bd_pins BusController16_1/AXIARValid] [get_bd_pins ila_0/probe7] [get_bd_pins processing_system7_0/S_AXI_GP0_ARVALID]
  connect_bd_net -net BusController16_0_AXIAWAddr [get_bd_pins BusController16_1/AXIAWAddr] [get_bd_pins ila_0/probe15] [get_bd_pins processing_system7_0/S_AXI_GP0_AWADDR]
  connect_bd_net -net BusController16_0_AXIAWBurst [get_bd_pins BusController16_1/AXIAWBurst] [get_bd_pins ila_0/probe19] [get_bd_pins processing_system7_0/S_AXI_GP0_AWBURST]
  connect_bd_net -net BusController16_0_AXIAWLen [get_bd_pins BusController16_1/AXIAWLen] [get_bd_pins ila_0/probe20] [get_bd_pins processing_system7_0/S_AXI_GP0_AWLEN]
  connect_bd_net -net BusController16_0_AXIAWSize [get_bd_pins BusController16_1/AXIAWSize] [get_bd_pins ila_0/probe21] [get_bd_pins processing_system7_0/S_AXI_GP0_AWSIZE]
  connect_bd_net -net BusController16_0_AXIAWValid [get_bd_pins BusController16_1/AXIAWValid] [get_bd_pins ila_0/probe18] [get_bd_pins processing_system7_0/S_AXI_GP0_AWVALID]
  connect_bd_net -net BusController16_0_AXIBReady [get_bd_pins BusController16_1/AXIBReady] [get_bd_pins ila_0/probe24] [get_bd_pins processing_system7_0/S_AXI_GP0_BREADY]
  connect_bd_net -net BusController16_0_AXIRReady [get_bd_pins BusController16_1/AXIRReady] [get_bd_pins ila_0/probe8] [get_bd_pins processing_system7_0/S_AXI_GP0_RREADY]
  connect_bd_net -net BusController16_0_AXIWData [get_bd_pins BusController16_1/AXIWData] [get_bd_pins ila_0/probe16] [get_bd_pins processing_system7_0/S_AXI_GP0_WDATA]
  connect_bd_net -net BusController16_0_AXIWLast [get_bd_pins BusController16_1/AXIWLast] [get_bd_pins ila_0/probe22] [get_bd_pins processing_system7_0/S_AXI_GP0_WLAST]
  connect_bd_net -net BusController16_0_AXIWStrb [get_bd_pins BusController16_1/AXIWStrb] [get_bd_pins ila_0/probe23] [get_bd_pins processing_system7_0/S_AXI_GP0_WSTRB]
  connect_bd_net -net BusController16_0_AXIWValid [get_bd_pins BusController16_1/AXIWValid] [get_bd_pins ila_0/probe17] [get_bd_pins processing_system7_0/S_AXI_GP0_WVALID]
  connect_bd_net -net BusController16_0_InD [get_bd_ports In_Da] [get_bd_pins BusController16_1/InD] [get_bd_pins ila_0/probe1]
  connect_bd_net -net BusController16_0_Ready [get_bd_ports Ready] [get_bd_pins BusController16_1/Ready] [get_bd_pins ila_0/probe2]
  connect_bd_net -net BusController16_1_AXIARBurst [get_bd_pins BusController16_1/AXIARBurst] [get_bd_pins processing_system7_0/S_AXI_GP0_ARBURST]
  connect_bd_net -net BusController16_1_bus_err [get_bd_ports bus_err] [get_bd_pins BusController16_1/bus_err]
  connect_bd_net -net BusController16_1_cache_en [get_bd_ports cache_en] [get_bd_pins BusController16_1/cache_en]
  connect_bd_net -net BusController16_1_hard_int [get_bd_ports hard_int] [get_bd_pins BusController16_1/hard_int]
  connect_bd_net -net BusController16_1_nmi_n [get_bd_ports nmi_n] [get_bd_pins BusController16_1/nmi_n]
  connect_bd_net -net BusController16_1_reset_n [get_bd_ports reset_n] [get_bd_pins BusController16_1/reset_n]
  connect_bd_net -net BusController16_1_tlb_en [get_bd_ports tlb_en] [get_bd_pins BusController16_1/tlb_en]
  connect_bd_net -net ByteEn_1 [get_bd_ports ByteEn] [get_bd_pins BusController16_1/ByteEnable]
  connect_bd_net -net Out_Da_1 [get_bd_ports Out_Da] [get_bd_pins BusController16_1/OutDA] [get_bd_pins ila_0/probe0]
  connect_bd_net -net Strobe_1 [get_bd_ports Strobe] [get_bd_pins BusController16_1/Strobe] [get_bd_pins ila_0/probe3]
  connect_bd_net -net Write_1 [get_bd_ports Write] [get_bd_pins BusController16_1/Write] [get_bd_pins ila_0/probe4]
  connect_bd_net -net axi_bram_ctrl_0_bram_addr_a [get_bd_pins axi_bram_ctrl_0/bram_addr_a] [get_bd_pins blk_mem_gen_0/addra]
  connect_bd_net -net axi_bram_ctrl_0_bram_clk_a [get_bd_pins axi_bram_ctrl_0/bram_clk_a] [get_bd_pins blk_mem_gen_0/clka]
  connect_bd_net -net axi_bram_ctrl_0_bram_en_a [get_bd_pins axi_bram_ctrl_0/bram_en_a] [get_bd_pins blk_mem_gen_0/ena]
  connect_bd_net -net axi_bram_ctrl_0_bram_we_a [get_bd_pins axi_bram_ctrl_0/bram_we_a] [get_bd_pins blk_mem_gen_0/wea]
  connect_bd_net -net axi_bram_ctrl_0_bram_wrdata_a [get_bd_pins axi_bram_ctrl_0/bram_wrdata_a] [get_bd_pins blk_mem_gen_0/dina]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins BusController16_1/Reset_] [get_bd_pins axi_gpio_0/gpio_io_o]
  connect_bd_net -net blk_mem_gen_0_douta [get_bd_pins axi_bram_ctrl_0/bram_rddata_a] [get_bd_pins blk_mem_gen_0/douta]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports clk_1] [get_bd_pins BusController16_1/Clk] [get_bd_pins clk_wiz_0/clk_out1]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports clk_0] [get_bd_pins BusController16_1/CoreClk] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins BusController16_1/AXIClock] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins ila_0/clk] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins clk_wiz_0/s_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins clk_wiz_0/s_axi_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_ARREADY [get_bd_pins BusController16_1/AXIARReady] [get_bd_pins ila_0/probe11] [get_bd_pins processing_system7_0/S_AXI_GP0_ARREADY]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_AWREADY [get_bd_pins BusController16_1/AXIAWReady] [get_bd_pins ila_0/probe26] [get_bd_pins processing_system7_0/S_AXI_GP0_AWREADY]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_BRESP [get_bd_pins BusController16_1/AXIBResp] [get_bd_pins ila_0/probe27] [get_bd_pins processing_system7_0/S_AXI_GP0_BRESP]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_BVALID [get_bd_pins BusController16_1/AXIBValid] [get_bd_pins ila_0/probe28] [get_bd_pins processing_system7_0/S_AXI_GP0_BVALID]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_RDATA [get_bd_pins BusController16_1/AXIRData] [get_bd_pins ila_0/probe25] [get_bd_pins processing_system7_0/S_AXI_GP0_RDATA]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_RLAST [get_bd_pins BusController16_1/AXIRLast] [get_bd_pins ila_0/probe13] [get_bd_pins processing_system7_0/S_AXI_GP0_RLAST]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_RRESP [get_bd_pins BusController16_1/AXIRResp] [get_bd_pins ila_0/probe14] [get_bd_pins processing_system7_0/S_AXI_GP0_RRESP]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_RVALID [get_bd_pins BusController16_1/AXIRValid] [get_bd_pins ila_0/probe12] [get_bd_pins processing_system7_0/S_AXI_GP0_RVALID]
  connect_bd_net -net processing_system7_0_S_AXI_GP0_WREADY [get_bd_pins BusController16_1/AXIWReady] [get_bd_pins ila_0/probe29] [get_bd_pins processing_system7_0/S_AXI_GP0_WREADY]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x2000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs clk_wiz_0/s_axi_lite/Reg] SEG_clk_wiz_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port Strobe -pg 1 -y 340 -defaultsOSRD
preplace port DDR -pg 1 -y 1270 -defaultsOSRD
preplace port cache_en -pg 1 -y 950 -defaultsOSRD
preplace port tlb_en -pg 1 -y 970 -defaultsOSRD
preplace port nmi_n -pg 1 -y 1010 -defaultsOSRD
preplace port Ready -pg 1 -y 870 -defaultsOSRD
preplace port clk_0 -pg 1 -y 910 -defaultsOSRD
preplace port reset_n -pg 1 -y 930 -defaultsOSRD
preplace port clk_1 -pg 1 -y 890 -defaultsOSRD
preplace port Blk -pg 1 -y 580 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 1290 -defaultsOSRD
preplace port hard_int -pg 1 -y 1030 -defaultsOSRD
preplace port Write -pg 1 -y 560 -defaultsOSRD
preplace port bus_err -pg 1 -y 990 -defaultsOSRD
preplace portBus ByteEn -pg 1 -y 600 -defaultsOSRD
preplace portBus Out_Da -pg 1 -y 620 -defaultsOSRD
preplace portBus In_Da -pg 1 -y 850 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 2 -y 230 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 2 -y 450 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 4 -y 280 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 5 -y 100 -defaultsOSRD
preplace inst ila_0 -pg 1 -lvl 5 -y 540 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 4 -y 480 -defaultsOSRD
preplace inst BusController16_1 -pg 1 -lvl 1 -y 650 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 4 -y 110 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 3 -y 180 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 2 -y 1350 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 2 4 NJ 1270 NJ 1270 NJ 1270 NJ
preplace netloc axi_bram_ctrl_0_bram_clk_a 1 4 1 N
preplace netloc axi_bram_ctrl_0_bram_addr_a 1 4 1 N
preplace netloc BusController16_0_AXIARLen 1 1 4 400 550 NJ 550 NJ 560 NJ
preplace netloc BusController16_1_reset_n 1 1 5 NJ 790 NJ 790 NJ 790 NJ 930 NJ
preplace netloc BusController16_0_AXIWStrb 1 1 4 520 720 NJ 720 NJ 720 NJ
preplace netloc BusController16_0_AXIAWLen 1 1 4 390 620 NJ 620 NJ 620 NJ
preplace netloc BusController16_0_AXIBReady 1 1 4 640 730 NJ 730 NJ 730 NJ
preplace netloc processing_system7_0_S_AXI_GP0_BVALID 1 0 5 90 360 550 840 NJ 840 NJ 840 NJ
preplace netloc BusController16_0_InD 1 1 5 600 750 NJ 750 NJ 750 2040 890 NJ
preplace netloc Strobe_1 1 0 5 -30 120 NJ 120 NJ 350 NJ 350 1890
preplace netloc ByteEn_1 1 0 1 NJ
preplace netloc Blk_1 1 0 5 -10 230 NJ 320 NJ 370 NJ 370 1910
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 3 1 1550
preplace netloc BusController16_1_cache_en 1 1 5 NJ 800 NJ 800 NJ 800 NJ 950 NJ
preplace netloc BusController16_0_AXIARValid 1 1 4 460 590 NJ 590 NJ 590 NJ
preplace netloc processing_system7_0_S_AXI_GP0_AWREADY 1 0 5 50 310 660 770 NJ 770 NJ 770 NJ
preplace netloc processing_system7_0_S_AXI_GP0_ARREADY 1 0 5 110 320 650 870 NJ 870 NJ 870 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 2 1 1200
preplace netloc BusController16_1_bus_err 1 1 5 NJ 850 NJ 850 NJ 850 NJ 990 NJ
preplace netloc processing_system7_0_S_AXI_GP0_RDATA 1 0 5 120 350 490 780 NJ 780 NJ 780 1890
preplace netloc processing_system7_0_S_AXI_GP0_RLAST 1 0 5 70 300 620 650 NJ 650 NJ 650 NJ
preplace netloc processing_system7_0_FCLK_RESET0_N 1 1 2 730 360 1160
preplace netloc BusController16_1_hard_int 1 1 5 NJ 890 NJ 890 NJ 890 NJ 1030 NJ
preplace netloc processing_system7_0_S_AXI_GP0_WREADY 1 0 5 80 340 530 820 NJ 820 NJ 820 N
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 3 1 1560
preplace netloc BusController16_0_AXIWValid 1 1 4 410 740 NJ 740 NJ 740 NJ
preplace netloc processing_system7_0_S_AXI_GP0_BRESP 1 0 5 10 290 580 830 NJ 830 NJ 830 NJ
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 2 2 1260 20 1590
preplace netloc BusController16_1_tlb_en 1 1 5 NJ 810 NJ 810 NJ 810 NJ 970 NJ
preplace netloc BusController16_0_AXIWData 1 1 4 560 700 NJ 700 NJ 700 NJ
preplace netloc BusController16_0_AXIAWBurst 1 1 4 570 610 NJ 610 NJ 610 NJ
preplace netloc axi_gpio_0_gpio_io_o 1 0 5 60 250 NJ 330 NJ 390 NJ 390 1850
preplace netloc processing_system7_0_FIXED_IO 1 2 4 NJ 1290 NJ 1290 NJ 1290 NJ
preplace netloc axi_bram_ctrl_0_bram_wrdata_a 1 4 1 N
preplace netloc BusController16_0_AXIARSize 1 1 4 440 580 NJ 580 NJ 580 NJ
preplace netloc BusController16_0_AXIWLast 1 1 4 590 710 NJ 710 NJ 710 NJ
preplace netloc BusController16_0_AXIAWValid 1 1 4 450 630 NJ 630 NJ 630 NJ
preplace netloc clk_wiz_0_clk_out1 1 0 6 100 280 NJ 860 NJ 860 NJ 860 1970 910 NJ
preplace netloc Out_Da_1 1 0 5 -20 140 NJ 140 NJ 380 NJ 380 1880
preplace netloc BusController16_1_nmi_n 1 1 5 NJ 900 NJ 900 NJ 900 NJ 1010 NJ
preplace netloc axi_bram_ctrl_0_bram_we_a 1 4 1 1860
preplace netloc blk_mem_gen_0_douta 1 4 1 N
preplace netloc clk_wiz_0_clk_out2 1 0 6 130 330 NJ 640 NJ 640 NJ 640 1940 920 NJ
preplace netloc Write_1 1 0 5 0 240 NJ 340 NJ 340 NJ 360 1900
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 2 2 1240 490 N
preplace netloc BusController16_0_AXIAWAddr 1 1 4 510 600 NJ 600 NJ 600 NJ
preplace netloc BusController16_0_AXIRReady 1 1 4 420 690 NJ 690 NJ 690 NJ
preplace netloc processing_system7_0_S_AXI_GP0_RVALID 1 0 5 40 270 670 670 NJ 670 NJ 670 NJ
preplace netloc BusController16_0_Ready 1 1 5 610 760 NJ 760 NJ 760 1870 900 NJ
preplace netloc clk_wiz_0_clk_out3 1 0 5 30 210 480 130 1250 10 1580 400 1860
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 2 1 1230
preplace netloc processing_system7_0_FCLK_CLK0 1 1 3 740 350 1210 470 1560
preplace netloc axi_bram_ctrl_0_bram_en_a 1 4 1 N
preplace netloc BusController16_0_AXIAWSize 1 1 4 370 680 NJ 680 NJ 680 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 3 1 1570
preplace netloc BusController16_1_AXIARBurst 1 1 1 380
preplace netloc BusController16_0_AXIARAddr 1 1 4 430 570 NJ 570 NJ 570 NJ
preplace netloc processing_system7_0_S_AXI_GP0_RRESP 1 0 5 20 260 630 660 NJ 660 NJ 660 2000
levelinfo -pg 1 -50 250 950 1400 1720 2160 2300 -top 0 -bot 1810
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


