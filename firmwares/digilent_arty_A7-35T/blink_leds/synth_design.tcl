# ------------------------------------------------------------------------------

# set output directory
cd ./build

# load FPGA pin-out
set fpga_root ./../../../../../fpga

set xdc_dir $fpga_root/boards/arty_A7-35T/xdc
read_xdc $xdc_dir/arty_osc.xdc
read_xdc $xdc_dir/arty_hid.xdc
read_xdc $xdc_dir/arty_board.xdc

set top top_blink_leds
read_vhdl -vhdl2008 ./../top/top_blink_leds.vhd

# create minimal design and save
set_property part xc7a35ticsg324-1L [current_project]
synth_design -top [lindex [find_top] 0] -verbose
write_checkpoint -force synth_design.dcp
report_timing_summary -file synth_design_timing_summary.rpt
