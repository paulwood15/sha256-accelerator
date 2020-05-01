# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 1
set_msg_config -id {HDL-1065} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/904pa/Documents/Git/sha256/project/sha256.cache/wt [current_project]
set_property parent.project_path C:/Users/904pa/Documents/Git/sha256/project/sha256.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {C:/Users/904pa/AppData/Roaming/Xilinx/Vivado/2019.2/xhub/board_store} [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_repo_paths {
  c:/Users/904pa/Documents/Git/sha256/ip_repo/axi_sha256_1.0
  c:/Users/904pa/Documents/Git/sha256/ip_repo/axi_sha256_1.0
  c:/Users/904pa/Documents/Git/sha256/ip_repo/myip_1.0
  c:/Users/904pa/Documents/Git/sha256/ip_repo/led_axi_1.0
} [current_project]
update_ip_catalog
set_property ip_output_repo c:/Users/904pa/Documents/Git/sha256/project/sha256.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog {
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/sha256.vh
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/testbench.vh
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/sha256types.vh
}
read_mem {
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/scheduler_vect_output.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/scheduler_vect_input.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/kvals.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/ihashvals.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/compressor_vect_input.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/default.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/update_vect_input0.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/update_vect_input1.mem
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/update_vect_output1.mem
}
read_verilog -library xil_defaultlib {
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/compressor.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/ram.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/scheduler.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/sha256_core.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/sha256_update.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/hasher.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/rom.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/reg_delay.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/new/padder.v
  C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/hdl/test_wrapper.v
}
add_files C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/test.bd
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_0/test_microblaze_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_0/test_microblaze_0_0_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_0/test_microblaze_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_dlmb_v10_0/test_dlmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_dlmb_v10_0/test_dlmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_ilmb_v10_0/test_ilmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_ilmb_v10_0/test_ilmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_dlmb_bram_if_cntlr_0/test_dlmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_ilmb_bram_if_cntlr_0/test_ilmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_lmb_bram_0/test_lmb_bram_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_xbar_0/test_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_axi_intc_0/test_microblaze_0_axi_intc_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_axi_intc_0/test_microblaze_0_axi_intc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_axi_intc_0/test_microblaze_0_axi_intc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_mdm_1_0/test_mdm_1_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_mdm_1_0/test_mdm_1_0_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_mdm_1_0/test_mdm_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_clk_wiz_1_0/test_clk_wiz_1_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_clk_wiz_1_0/test_clk_wiz_1_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_clk_wiz_1_0/test_clk_wiz_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_rst_clk_wiz_1_100M_0/test_rst_clk_wiz_1_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_rst_clk_wiz_1_100M_0/test_rst_clk_wiz_1_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_rst_clk_wiz_1_100M_0/test_rst_clk_wiz_1_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_axi_uartlite_0_0/test_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_axi_uartlite_0_0/test_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_axi_uartlite_0_0/test_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_auto_pc_0/test_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/test_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/sources_1/bd/test/ip/test_microblaze_0_0/data/mb_bootloop_le.elf]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/constrs_1/new/pins_constr.xdc
set_property used_in_implementation false [get_files C:/Users/904pa/Documents/Git/sha256/project/sha256.srcs/constrs_1/new/pins_constr.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top test_wrapper -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef test_wrapper.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file test_wrapper_utilization_synth.rpt -pb test_wrapper_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
