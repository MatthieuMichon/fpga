# ------------------------------------------------------------------------------

# use work directory
cd ./build

# ------------------------------------------------------------------------------
# Import Source Files
# ------------------------------------------------------------------------------
set fpga_root ./../../../../../fpga

# Constraints Files

set xdc_dir $fpga_root/boards/arty_A7-35T/xdc
read_xdc $xdc_dir/arty_osc.xdc
read_xdc $xdc_dir/arty_hid.xdc
read_xdc $xdc_dir/arty_board.xdc

# HDL Files

read_vhdl -vhdl2008 ./../top/top_vio_tcl.vhd

# ------------------------------------------------------------------------------
# Create Vendor IPs
# ------------------------------------------------------------------------------

set_property part xc7a35ticsg324-1L [current_project]

# VIO
create_ip -name vio -vendor xilinx.com -library ip -version 3.0 -module_name vio_arty -dir ./
set_property -dict [list CONFIG.C_PROBE_OUT3_WIDTH {3} CONFIG.C_PROBE_OUT2_WIDTH {3} CONFIG.C_PROBE_OUT1_WIDTH {3} CONFIG.C_PROBE_OUT0_WIDTH {3} CONFIG.C_PROBE_IN2_WIDTH {4} CONFIG.C_PROBE_IN1_WIDTH {4} CONFIG.C_PROBE_IN0_WIDTH {1} CONFIG.C_NUM_PROBE_OUT {8} CONFIG.C_NUM_PROBE_IN {3}] [get_ips vio_arty]
#read_ip ./vio_arty/vio_arty.xci
synth_ip [get_ips]
# set_property target_language VHDL [current_project]
# generate_target all [get_files  ./vio_arty/vio_arty.xci]
#read_verilog ./vio_arty/synth/vio_arty.v
# add_files -norecurse ./vio_arty/vio_arty.xci
# export_ip_user_files -of_objects  [get_files  ./vio_arty/vio_arty.xci]
# update_compile_order -fileset sources_1

# create minimal design and save
synth_design -top [lindex [find_top] 0] -verbose
write_checkpoint -force synth_design.dcp
report_timing_summary -file synth_design_timing_summary.rpt

