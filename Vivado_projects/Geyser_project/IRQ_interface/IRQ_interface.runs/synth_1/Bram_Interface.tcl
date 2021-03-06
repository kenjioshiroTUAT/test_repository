# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xc7z020clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Vivado_projects/IRQ_interface/IRQ_interface.cache/wt [current_project]
set_property parent.project_path C:/Vivado_projects/IRQ_interface/IRQ_interface.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:microzed_7020:part0:1.1 [current_project]
set_property ip_repo_paths c:/Vivado_projects/IRQ_interface/IRQ_interface.srcs/sources_1/new [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib C:/Vivado_projects/IRQ_interface/IRQ_interface.srcs/sources_1/new/IRQ_interface.v
synth_design -top Bram_Interface -part xc7z020clg400-1
write_checkpoint -noxdef Bram_Interface.dcp
catch { report_utilization -file Bram_Interface_utilization_synth.rpt -pb Bram_Interface_utilization_synth.pb }
