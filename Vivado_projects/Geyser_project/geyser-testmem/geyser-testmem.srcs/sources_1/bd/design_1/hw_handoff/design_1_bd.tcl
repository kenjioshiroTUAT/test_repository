
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
  set DDR_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR_0 ]
  set FIXED_IO_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO_0 ]

  # Create ports
  set Blk [ create_bd_port -dir I Blk ]
  set ByteEnable [ create_bd_port -dir I -from 3 -to 0 ByteEnable ]
  set InD [ create_bd_port -dir O -from 15 -to 0 InD ]
  set OutDA [ create_bd_port -dir I -from 15 -to 0 OutDA ]
  set Ready [ create_bd_port -dir O Ready ]
  set Strobe [ create_bd_port -dir I Strobe ]
  set Write [ create_bd_port -dir I Write ]
  set bus_err [ create_bd_port -dir O bus_err ]
  set cache_en [ create_bd_port -dir O cache_en ]
  set clk0 [ create_bd_port -dir O clk0 ]
  set clk1 [ create_bd_port -dir O clk1 ]
  set hard_int [ create_bd_port -dir O hard_int ]
  set nmi_n [ create_bd_port -dir O nmi_n ]
  set reset_n [ create_bd_port -dir O -from 0 -to 0 reset_n ]
  set tlb_en [ create_bd_port -dir O tlb_en ]

  # Create instance: Bram_Interface_0, and set properties
  set Bram_Interface_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:Bram_Interface:1.0 Bram_Interface_0 ]

  # Create instance: Bram_Interface_1, and set properties
  set Bram_Interface_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:Bram_Interface:1.0 Bram_Interface_1 ]

  # Create instance: BusController16_1, and set properties
  set BusController16_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:BusController16:1.0 BusController16_1 ]

  # Create instance: IRQ_Interface_1, and set properties
  set IRQ_Interface_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:IRQ_Interface:1.0 IRQ_Interface_1 ]

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
CONFIG.Coe_File {../../../../../../../source_code/Geyser_mem_01/COE/btst.coe} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_A {Use_ENA_Pin} \
CONFIG.Enable_B {Always_Enabled} \
CONFIG.Load_Init_File {true} \
CONFIG.Memory_Type {Single_Port_RAM} \
CONFIG.Operating_Mode_A {NO_CHANGE} \
CONFIG.Port_A_Write_Rate {50} \
CONFIG.Port_B_Clock {0} \
CONFIG.Port_B_Enable_Rate {0} \
CONFIG.Read_Width_A {16} \
CONFIG.Read_Width_B {16} \
CONFIG.Register_PortA_Output_of_Memory_Core {false} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Write_Width_A {16} \
CONFIG.Write_Width_B {16} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_1 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Coe_File {../../../../../../../source_code/Geyser_mem_01/COE/bram.coe} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_B {Always_Enabled} \
CONFIG.Load_Init_File {true} \
CONFIG.Memory_Type {Single_Port_RAM} \
CONFIG.Operating_Mode_A {NO_CHANGE} \
CONFIG.Port_B_Clock {0} \
CONFIG.Port_B_Enable_Rate {0} \
CONFIG.Port_B_Write_Rate {0} \
CONFIG.Read_Width_A {16} \
CONFIG.Read_Width_B {16} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Use_RSTB_Pin {false} \
CONFIG.Write_Width_A {16} \
CONFIG.Write_Width_B {16} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_1

  # Create instance: blk_mem_gen_2, and set properties
  set blk_mem_gen_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_2 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Coe_File {../../../../../../../source_code/Geyser_mem_01/COE/btst2.coe} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_B {Use_ENB_Pin} \
CONFIG.Load_Init_File {true} \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Port_B_Write_Rate {50} \
CONFIG.Read_Width_A {16} \
CONFIG.Read_Width_B {32} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Use_RSTB_Pin {false} \
CONFIG.Write_Depth_A {8192} \
CONFIG.Write_Width_A {16} \
CONFIG.Write_Width_B {32} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_2

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {292.088} \
CONFIG.CLKOUT1_PHASE_ERROR {298.923} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {30.000} \
CONFIG.CLKOUT2_JITTER {332.016} \
CONFIG.CLKOUT2_PHASE_ERROR {298.923} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {15.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.CLKOUT3_JITTER {187.401} \
CONFIG.CLKOUT3_PHASE_ERROR {94.994} \
CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {15.000} \
CONFIG.CLKOUT3_USED {false} \
CONFIG.MMCM_CLKFBOUT_MULT_F {50.250} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {33.500} \
CONFIG.MMCM_CLKOUT1_DIVIDE {67} \
CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
CONFIG.MMCM_DIVCLK_DIVIDE {5} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.RESET_PORT {reset} \
CONFIG.RESET_TYPE {ACTIVE_HIGH} \
CONFIG.USE_DYN_RECONFIG {true} \
 ] $clk_wiz_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_0 ]
  set_property -dict [ list \
CONFIG.C_DATA_DEPTH {16384} \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {10} \
CONFIG.C_PROBE2_WIDTH {16} \
CONFIG.C_PROBE3_WIDTH {16} \
CONFIG.C_PROBE6_WIDTH {13} \
CONFIG.C_PROBE7_WIDTH {16} \
CONFIG.C_PROBE8_WIDTH {16} \
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
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C_RESET_ENABLE {0} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
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
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
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
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_M_AXI_GP1 {0} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {3} \
CONFIG.NUM_SI {1} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: trans_addr_12to11_0, and set properties
  set trans_addr_12to11_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:trans_addr_12to11:1.0 trans_addr_12to11_0 ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {1} \
 ] $xlconcat_0

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR_0] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO_0] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins clk_wiz_0/s_axi_lite] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]

  # Create port connections
  connect_bd_net -net Blk_1 [get_bd_ports Blk] [get_bd_pins BusController16_1/Block]
  connect_bd_net -net Bram_Interface_0_RdData [get_bd_pins Bram_Interface_0/RdData] [get_bd_pins BusController16_1/rom_RdData]
  connect_bd_net -net Bram_Interface_0_bram_addr [get_bd_pins Bram_Interface_0/bram_addr] [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins ila_0/probe6]
  connect_bd_net -net Bram_Interface_0_clk [get_bd_pins Bram_Interface_0/clk] [get_bd_pins blk_mem_gen_0/clka]
  connect_bd_net -net Bram_Interface_0_din [get_bd_pins Bram_Interface_0/din] [get_bd_pins blk_mem_gen_0/dina] [get_bd_pins ila_0/probe8]
  connect_bd_net -net Bram_Interface_0_en [get_bd_pins Bram_Interface_0/en] [get_bd_pins blk_mem_gen_0/ena]
  connect_bd_net -net Bram_Interface_0_we [get_bd_pins Bram_Interface_0/we] [get_bd_pins blk_mem_gen_0/wea]
  connect_bd_net -net Bram_Interface_1_RdData [get_bd_pins Bram_Interface_1/RdData] [get_bd_pins BusController16_1/ram_RdData]
  connect_bd_net -net Bram_Interface_1_bram_addr [get_bd_pins Bram_Interface_1/bram_addr] [get_bd_pins blk_mem_gen_1/addra]
  connect_bd_net -net Bram_Interface_1_clk [get_bd_pins Bram_Interface_1/clk] [get_bd_pins blk_mem_gen_1/clka]
  connect_bd_net -net Bram_Interface_1_din [get_bd_pins Bram_Interface_1/din] [get_bd_pins blk_mem_gen_1/dina]
  connect_bd_net -net Bram_Interface_1_en [get_bd_pins Bram_Interface_1/en] [get_bd_pins blk_mem_gen_1/ena]
  connect_bd_net -net Bram_Interface_1_we [get_bd_pins Bram_Interface_1/we] [get_bd_pins blk_mem_gen_1/wea]
  connect_bd_net -net BusController16_1_InD [get_bd_ports InD] [get_bd_pins BusController16_1/InD] [get_bd_pins ila_0/probe3]
  connect_bd_net -net BusController16_1_Ready [get_bd_ports Ready] [get_bd_pins BusController16_1/Ready] [get_bd_pins ila_0/probe4]
  connect_bd_net -net BusController16_1_bus_err [get_bd_ports bus_err] [get_bd_pins BusController16_1/bus_err]
  connect_bd_net -net BusController16_1_cache_en [get_bd_ports cache_en] [get_bd_pins BusController16_1/cache_en]
  connect_bd_net -net BusController16_1_hard_int [get_bd_ports hard_int] [get_bd_pins BusController16_1/hard_int]
  connect_bd_net -net BusController16_1_nmi_n [get_bd_ports nmi_n] [get_bd_pins BusController16_1/nmi_n]
  connect_bd_net -net BusController16_1_ram_ByteEnable [get_bd_pins Bram_Interface_1/ByteEn] [get_bd_pins BusController16_1/ram_ByteEnable]
  connect_bd_net -net BusController16_1_ram_OEn [get_bd_pins Bram_Interface_1/OEn] [get_bd_pins BusController16_1/ram_OEn]
  connect_bd_net -net BusController16_1_ram_WEn [get_bd_pins Bram_Interface_1/WEn] [get_bd_pins BusController16_1/ram_WEn]
  connect_bd_net -net BusController16_1_ram_WrData [get_bd_pins Bram_Interface_1/WrData] [get_bd_pins BusController16_1/ram_WrData]
  connect_bd_net -net BusController16_1_ram_addr [get_bd_pins Bram_Interface_1/Address] [get_bd_pins BusController16_1/ram_addr]
  connect_bd_net -net BusController16_1_ram_en [get_bd_pins Bram_Interface_1/Strobe] [get_bd_pins BusController16_1/ram_en]
  connect_bd_net -net BusController16_1_reset_n [get_bd_ports reset_n] [get_bd_pins BusController16_1/reset_n] [get_bd_pins ila_0/probe5]
  connect_bd_net -net BusController16_1_rom_ByteEnable [get_bd_pins Bram_Interface_0/ByteEn] [get_bd_pins BusController16_1/rom_ByteEnable]
  connect_bd_net -net BusController16_1_rom_OEn [get_bd_pins Bram_Interface_0/OEn] [get_bd_pins BusController16_1/rom_OEn]
  connect_bd_net -net BusController16_1_rom_WEn [get_bd_pins Bram_Interface_0/WEn] [get_bd_pins BusController16_1/rom_WEn]
  connect_bd_net -net BusController16_1_rom_WrData [get_bd_pins Bram_Interface_0/WrData] [get_bd_pins BusController16_1/rom_WrData]
  connect_bd_net -net BusController16_1_rom_addr [get_bd_pins Bram_Interface_0/Address] [get_bd_pins BusController16_1/rom_addr]
  connect_bd_net -net BusController16_1_rom_en [get_bd_pins Bram_Interface_0/Strobe] [get_bd_pins BusController16_1/rom_en]
  connect_bd_net -net BusController16_1_shared_ByteEnable [get_bd_pins BusController16_1/shared_ByteEnable] [get_bd_pins IRQ_Interface_1/ByteEn]
  connect_bd_net -net BusController16_1_shared_OEn [get_bd_pins BusController16_1/shared_OEn] [get_bd_pins IRQ_Interface_1/OEn]
  connect_bd_net -net BusController16_1_shared_WEn [get_bd_pins BusController16_1/shared_WEn] [get_bd_pins IRQ_Interface_1/WEn]
  connect_bd_net -net BusController16_1_shared_WrData [get_bd_pins BusController16_1/shared_WrData] [get_bd_pins IRQ_Interface_1/WrData]
  connect_bd_net -net BusController16_1_shared_addr [get_bd_pins BusController16_1/shared_addr] [get_bd_pins IRQ_Interface_1/Address]
  connect_bd_net -net BusController16_1_shared_en [get_bd_pins BusController16_1/shared_en] [get_bd_pins IRQ_Interface_1/Strobe]
  connect_bd_net -net BusController16_1_tlb_en [get_bd_ports tlb_en] [get_bd_pins BusController16_1/tlb_en]
  connect_bd_net -net ByteEnable_1 [get_bd_ports ByteEnable] [get_bd_pins BusController16_1/ByteEnable]
  connect_bd_net -net IRQ_Interface_1_RdData [get_bd_pins BusController16_1/shared_RdData] [get_bd_pins IRQ_Interface_1/RdData]
  connect_bd_net -net IRQ_Interface_1_bram_addr [get_bd_pins IRQ_Interface_1/bram_addr] [get_bd_pins blk_mem_gen_2/addra]
  connect_bd_net -net IRQ_Interface_1_clk [get_bd_pins IRQ_Interface_1/clk] [get_bd_pins blk_mem_gen_2/clka]
  connect_bd_net -net IRQ_Interface_1_din [get_bd_pins IRQ_Interface_1/din] [get_bd_pins blk_mem_gen_2/dina]
  connect_bd_net -net IRQ_Interface_1_en [get_bd_pins IRQ_Interface_1/en] [get_bd_pins blk_mem_gen_2/ena]
  connect_bd_net -net IRQ_Interface_1_irq [get_bd_pins IRQ_Interface_1/irq] [get_bd_pins ila_0/probe9] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net IRQ_Interface_1_we [get_bd_pins IRQ_Interface_1/we] [get_bd_pins blk_mem_gen_2/wea]
  connect_bd_net -net OutDA_1 [get_bd_ports OutDA] [get_bd_pins BusController16_1/OutDA] [get_bd_pins ila_0/probe2]
  connect_bd_net -net Strobe_1 [get_bd_ports Strobe] [get_bd_pins BusController16_1/Strobe] [get_bd_pins ila_0/probe0]
  connect_bd_net -net Write_1 [get_bd_ports Write] [get_bd_pins BusController16_1/Write] [get_bd_pins ila_0/probe1]
  connect_bd_net -net axi_bram_ctrl_0_bram_addr_a [get_bd_pins axi_bram_ctrl_0/bram_addr_a] [get_bd_pins trans_addr_12to11_0/axi_bram_ctrl_addr]
  connect_bd_net -net axi_bram_ctrl_0_bram_clk_a [get_bd_pins axi_bram_ctrl_0/bram_clk_a] [get_bd_pins blk_mem_gen_2/clkb]
  connect_bd_net -net axi_bram_ctrl_0_bram_en_a [get_bd_pins axi_bram_ctrl_0/bram_en_a] [get_bd_pins blk_mem_gen_2/enb]
  connect_bd_net -net axi_bram_ctrl_0_bram_we_a [get_bd_pins axi_bram_ctrl_0/bram_we_a] [get_bd_pins blk_mem_gen_2/web]
  connect_bd_net -net axi_bram_ctrl_0_bram_wrdata_a [get_bd_pins axi_bram_ctrl_0/bram_wrdata_a] [get_bd_pins blk_mem_gen_2/dinb]
  connect_bd_net -net axi_gpio_0_gpio_io_o [get_bd_pins BusController16_1/Reset_] [get_bd_pins axi_gpio_0/gpio_io_o]
  connect_bd_net -net blk_mem_gen_0_douta [get_bd_pins Bram_Interface_0/dout] [get_bd_pins blk_mem_gen_0/douta] [get_bd_pins ila_0/probe7]
  connect_bd_net -net blk_mem_gen_1_douta [get_bd_pins Bram_Interface_1/dout] [get_bd_pins blk_mem_gen_1/douta]
  connect_bd_net -net blk_mem_gen_2_douta [get_bd_pins IRQ_Interface_1/dout] [get_bd_pins blk_mem_gen_2/douta]
  connect_bd_net -net blk_mem_gen_2_doutb [get_bd_pins axi_bram_ctrl_0/bram_rddata_a] [get_bd_pins blk_mem_gen_2/doutb]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_ports clk0] [get_bd_pins BusController16_1/CoreClk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins ila_0/clk] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_ports clk1] [get_bd_pins Bram_Interface_0/Clock] [get_bd_pins Bram_Interface_1/Clock] [get_bd_pins BusController16_1/Clk] [get_bd_pins IRQ_Interface_1/Clock] [get_bd_pins clk_wiz_0/clk_out2]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins clk_wiz_0/s_axi_aresetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins clk_wiz_0/s_axi_aclk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
  connect_bd_net -net trans_addr_12to11_0_my_bram_addr [get_bd_pins blk_mem_gen_2/addrb] [get_bd_pins trans_addr_12to11_0/my_bram_addr]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_0/IRQ_F2P] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x2000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs clk_wiz_0/s_axi_lite/Reg] SEG_clk_wiz_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port Strobe -pg 1 -y 1430 -defaultsOSRD
preplace port cache_en -pg 1 -y 810 -defaultsOSRD
preplace port clk0 -pg 1 -y 1680 -defaultsOSRD
preplace port tlb_en -pg 1 -y 830 -defaultsOSRD
preplace port clk1 -pg 1 -y 620 -defaultsOSRD
preplace port nmi_n -pg 1 -y 870 -defaultsOSRD
preplace port Ready -pg 1 -y 1700 -defaultsOSRD
preplace port DDR_0 -pg 1 -y 200 -defaultsOSRD
preplace port Blk -pg 1 -y 910 -defaultsOSRD
preplace port hard_int -pg 1 -y 890 -defaultsOSRD
preplace port Write -pg 1 -y 1450 -defaultsOSRD
preplace port bus_err -pg 1 -y 850 -defaultsOSRD
preplace port FIXED_IO_0 -pg 1 -y 220 -defaultsOSRD
preplace portBus OutDA -pg 1 -y 1410 -defaultsOSRD
preplace portBus ByteEnable -pg 1 -y 930 -defaultsOSRD
preplace portBus reset_n -pg 1 -y 1720 -defaultsOSRD
preplace portBus InD -pg 1 -y 1660 -defaultsOSRD
preplace inst trans_addr_12to11_0 -pg 1 -lvl 9 -y 970 -defaultsOSRD
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 6 -y 740 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 4 -y 190 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 6 -y 70 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 8 -y 750 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 6 -y 1480 -defaultsOSRD
preplace inst Bram_Interface_0 -pg 1 -lvl 1 -y 1290 -defaultsOSRD
preplace inst blk_mem_gen_1 -pg 1 -lvl 6 -y 540 -defaultsOSRD
preplace inst blk_mem_gen_2 -pg 1 -lvl 5 -y 1130 -defaultsOSRD
preplace inst Bram_Interface_1 -pg 1 -lvl 1 -y 340 -defaultsOSRD
preplace inst ila_0 -pg 1 -lvl 10 -y 1530 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 8 -y 620 -defaultsOSRD
preplace inst IRQ_Interface_1 -pg 1 -lvl 3 -y 1230 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 8 -y 1020 -defaultsOSRD
preplace inst BusController16_1 -pg 1 -lvl 2 -y 920 -defaultsOSRD
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 7 -y 640 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 6 -y 280 -defaultsOSRD
preplace netloc Bram_Interface_1_clk 1 1 5 NJ 330 NJ 330 NJ 330 NJ 330 NJ
preplace netloc OutDA_1 1 0 10 NJ 1410 260 1360 NJ 1360 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ 1350 NJ
preplace netloc Bram_Interface_0_din 1 1 9 NJ 1380 NJ 1380 NJ 1380 NJ 1380 NJ 1330 NJ 1330 NJ 1330 NJ 1330 NJ
preplace netloc BusController16_1_ram_WrData 1 0 3 -100 1120 NJ 1250 690
preplace netloc Bram_Interface_0_bram_addr 1 1 9 NJ 1450 NJ 1450 NJ 1450 NJ 1450 NJ 1600 NJ 1600 NJ 1600 NJ 1600 NJ
preplace netloc processing_system7_0_FIXED_IO 1 6 5 NJ 210 NJ 210 NJ 210 NJ 210 NJ
preplace netloc BusController16_1_shared_en 1 2 1 810
preplace netloc BusController16_1_nmi_n 1 2 9 NJ 810 NJ 810 NJ 810 NJ 860 NJ 860 NJ 860 NJ 860 NJ 860 NJ
preplace netloc trans_addr_12to11_0_my_bram_addr 1 4 6 1620 900 N 900 N 900 N 900 N 900 3340
preplace netloc xlconcat_0_dout 1 4 2 N 190 1990
preplace netloc Bram_Interface_0_en 1 1 5 NJ 1520 NJ 1520 NJ 1520 N 1520 N
preplace netloc Bram_Interface_1_din 1 1 5 NJ 350 NJ 350 NJ 350 NJ 350 NJ
preplace netloc IRQ_Interface_1_we 1 3 2 1420 1120 NJ
preplace netloc IRQ_Interface_1_en 1 3 2 1400 1100 NJ
preplace netloc BusController16_1_shared_OEn 1 2 1 840
preplace netloc BusController16_1_cache_en 1 2 9 NJ 750 NJ 750 NJ 750 NJ 850 NJ 850 NJ 850 NJ 810 NJ 810 NJ
preplace netloc Blk_1 1 0 2 NJ 910 NJ
preplace netloc Bram_Interface_1_bram_addr 1 1 5 NJ 310 NJ 310 NJ 310 NJ 310 NJ
preplace netloc processing_system7_0_DDR 1 6 5 NJ 190 NJ 190 NJ 190 NJ 190 NJ
preplace netloc axi_bram_ctrl_0_bram_we_a 1 4 5 1630 1320 N 1320 N 1320 N 1320 NJ
preplace netloc BusController16_1_shared_WEn 1 2 1 830
preplace netloc Strobe_1 1 0 10 NJ 1430 230 1370 NJ 1370 NJ 1360 NJ 1360 NJ 1360 NJ 1360 NJ 1360 NJ 1360 NJ
preplace netloc IRQ_Interface_1_bram_addr 1 3 2 1370 1020 NJ
preplace netloc BusController16_1_shared_WrData 1 2 1 820
preplace netloc processing_system7_0_FCLK_RESET0_N 1 5 2 2010 430 2370
preplace netloc axi_bram_ctrl_0_bram_clk_a 1 4 5 1620 1310 N 1310 N 1310 N 1310 NJ
preplace netloc BusController16_1_Ready 1 2 9 NJ 640 NJ 640 NJ 640 NJ 1620 NJ 1620 NJ 1620 NJ 1620 3380 1700 NJ
preplace netloc BusController16_1_shared_addr 1 2 1 860
preplace netloc BusController16_1_rom_ByteEnable 1 0 3 -120 1130 NJ 1280 780
preplace netloc blk_mem_gen_1_douta 1 0 6 -80 550 NJ 550 NJ 550 NJ 550 NJ 550 NJ
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 7 1 2710
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 6 2 2390 470 NJ
preplace netloc Bram_Interface_1_RdData 1 1 1 310
preplace netloc BusController16_1_ram_ByteEnable 1 0 3 -150 1420 NJ 1420 740
preplace netloc BusController16_1_InD 1 2 9 NJ 670 NJ 670 NJ 670 NJ 1610 NJ 1610 NJ 1610 NJ 1610 3340 1680 NJ
preplace netloc BusController16_1_rom_en 1 0 3 -90 1470 NJ 1470 790
preplace netloc BusController16_1_ram_en 1 0 3 -90 920 NJ 1270 710
preplace netloc BusController16_1_hard_int 1 2 9 NJ 830 NJ 830 NJ 830 NJ 890 NJ 890 NJ 890 NJ 890 NJ 890 NJ
preplace netloc Write_1 1 0 10 NJ 1450 270 1390 NJ 1390 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ 1370 NJ
preplace netloc ByteEnable_1 1 0 2 NJ 930 NJ
preplace netloc BusController16_1_rom_WEn 1 0 3 -100 1150 NJ 1300 760
preplace netloc BusController16_1_reset_n 1 2 9 NJ 730 NJ 730 NJ 730 NJ 1630 NJ 1630 NJ 1630 NJ 1630 3390 1720 NJ
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 7 1 2710
preplace netloc Bram_Interface_0_clk 1 1 5 NJ 1460 NJ 1460 NJ 1460 N 1460 N
preplace netloc BusController16_1_rom_addr 1 0 3 -80 1170 NJ 1320 800
preplace netloc IRQ_Interface_1_din 1 3 2 1390 1060 NJ
preplace netloc IRQ_Interface_1_irq 1 3 7 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ 1640 NJ
preplace netloc IRQ_Interface_1_clk 1 3 2 1380 1040 NJ
preplace netloc BusController16_1_ram_WEn 1 0 3 -110 1110 NJ 1240 700
preplace netloc processing_system7_0_FCLK_CLK0 1 5 3 2000 420 2380 460 2740
preplace netloc axi_bram_ctrl_0_bram_addr_a 1 8 1 NJ
preplace netloc BusController16_1_bus_err 1 2 9 NJ 790 NJ 790 NJ 790 NJ 840 NJ 840 NJ 840 NJ 840 NJ 840 NJ
preplace netloc BusController16_1_rom_WrData 1 0 3 -90 1160 NJ 1310 750
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 6 1 2410
preplace netloc Bram_Interface_0_RdData 1 1 1 240
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 7 1 2720
preplace netloc IRQ_Interface_1_RdData 1 1 3 340 1350 NJ 1350 1360
preplace netloc BusController16_1_tlb_en 1 2 9 NJ 770 NJ 770 NJ 770 NJ 870 NJ 870 NJ 830 NJ 830 NJ 830 NJ
preplace netloc Bram_Interface_1_en 1 1 5 NJ 370 NJ 370 NJ 370 NJ 370 NJ
preplace netloc Bram_Interface_1_we 1 1 5 NJ 390 NJ 390 NJ 390 NJ 390 NJ
preplace netloc BusController16_1_rom_OEn 1 0 3 -110 1140 NJ 1290 770
preplace netloc blk_mem_gen_2_douta 1 2 3 880 1080 NJ 1080 NJ
preplace netloc clk_wiz_0_clk_out1 1 1 10 330 570 NJ 570 NJ 570 N 570 1970 830 2400 830 2720 820 3020 820 3400 1380 NJ
preplace netloc processing_system7_0_M_AXI_GP0 1 6 1 2420
preplace netloc Bram_Interface_0_we 1 1 5 NJ 1330 NJ 1420 NJ 1420 N 1420 1830
preplace netloc clk_wiz_0_clk_out2 1 0 11 -130 600 320 600 870 650 NJ 650 NJ 650 NJ 650 NJ 480 NJ 480 3040 620 NJ 620 NJ
preplace netloc blk_mem_gen_2_doutb 1 4 5 1610 1330 1850 1340 N 1340 N 1340 NJ
preplace netloc BusController16_1_shared_ByteEnable 1 2 1 850
preplace netloc blk_mem_gen_0_douta 1 0 10 -80 1500 NJ 1500 NJ 1500 NJ 1500 NJ 1500 NJ 1590 NJ 1590 NJ 1590 NJ 1590 NJ
preplace netloc axi_gpio_0_gpio_io_o 1 1 8 340 580 NJ 580 NJ 580 NJ 580 NJ 880 NJ 880 NJ 880 3000
preplace netloc axi_bram_ctrl_0_bram_en_a 1 4 5 1600 910 N 910 N 910 N 910 NJ
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 6 2 2420 800 2740
preplace netloc BusController16_1_ram_addr 1 0 3 -120 890 NJ 1260 720
preplace netloc BusController16_1_ram_OEn 1 0 3 -140 1440 NJ 1440 730
preplace netloc axi_bram_ctrl_0_bram_wrdata_a 1 4 5 1630 950 N 950 N 950 2700 1130 NJ
levelinfo -pg 1 -170 40 540 1250 1520 1740 2190 2560 2870 3190 3480 3590 -top -10 -bot 1780
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


