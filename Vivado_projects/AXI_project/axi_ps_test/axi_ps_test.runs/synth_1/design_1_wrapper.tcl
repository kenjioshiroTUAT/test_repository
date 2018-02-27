# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Vivado_projects/axi_ps_test/axi_ps_test.cache/wt [current_project]
set_property parent.project_path C:/Vivado_projects/axi_ps_test/axi_ps_test.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:microzed_7020:part0:1.1 [current_project]
set_property ip_repo_paths c:/Vivado_projects/source_code/axi_test_code [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_axi_gpio_0_0/design_1_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/design_1_rst_processing_system7_0_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_xbar_0/design_1_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_ila_0_0/ila_v6_0/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_ila_0_0/design_1_ila_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_blk_mem_gen_0_0/design_1_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_0/design_1_axi_bram_ctrl_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_auto_cc_0/design_1_auto_cc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_auto_cc_0/design_1_auto_cc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_0/design_1_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_1/design_1_auto_pc_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/ip/design_1_auto_pc_2/design_1_auto_pc_2_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/design_1_ooc.xdc]
set_property is_locked true [get_files C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/design_1.bd]

read_verilog -library xil_defaultlib C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
read_xdc C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/constrs_1/new/constrains1.xdc
set_property used_in_implementation false [get_files C:/Vivado_projects/axi_ps_test/axi_ps_test.srcs/constrs_1/new/constrains1.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top design_1_wrapper -part xc7z020clg400-1
write_checkpoint -noxdef design_1_wrapper.dcp
catch { report_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pb }
