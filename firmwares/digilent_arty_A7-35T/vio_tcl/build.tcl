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
read_xdc $xdc_dir/arty_mii.xdc
read_xdc $xdc_dir/arty_board.xdc

# HDL Files

read_vhdl -vhdl2008 ./../top/top_vio_tcl.vhd

# ------------------------------------------------------------------------------
# Create Vendor IPs
# ------------------------------------------------------------------------------

# VIO
set_property part xc7a35ticsg324-1L [current_project]
create_ip -name vio -vendor xilinx.com -library ip -version 3.0 -module_name vio_arty -dir ./
set_property -dict [list \
	CONFIG.C_PROBE_OUT3_WIDTH {3} \
	CONFIG.C_PROBE_OUT2_WIDTH {3} \
	CONFIG.C_PROBE_OUT1_WIDTH {3} \
	CONFIG.C_PROBE_OUT0_WIDTH {3} \
	CONFIG.C_PROBE_IN3_WIDTH {3} \
	CONFIG.C_PROBE_IN2_WIDTH {4} \
	CONFIG.C_PROBE_IN1_WIDTH {4} \
	CONFIG.C_PROBE_IN0_WIDTH {1} \
	CONFIG.C_NUM_PROBE_OUT {8} \
	CONFIG.C_NUM_PROBE_IN {4}] [get_ips vio_arty]
synth_ip [get_ips]

# ------------------------------------------------------------------------------
# Synthesize
# ------------------------------------------------------------------------------

set_property part xc7a35ticsg324-1L [current_project]
synth_design -top [lindex [find_top] 0] -verbose
write_checkpoint -force synth_design.dcp
report_timing_summary -file synth_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Optimize
# ------------------------------------------------------------------------------

opt_design -directive Explore
write_checkpoint -force opt_design.dcp
report_timing_summary -file opt_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Place
# ------------------------------------------------------------------------------

place_design -directive Explore
write_checkpoint -force place_design.dcp
report_timing_summary -file place_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Post-Place Optimize
# ------------------------------------------------------------------------------

phys_opt_design
write_checkpoint -force post_place_opt_design.dcp
report_timing_summary -file post_place_opt_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Route
# ------------------------------------------------------------------------------

route_design
write_checkpoint -force route_design.dcp
report_timing_summary -file route_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Port-Route Optimize
# ------------------------------------------------------------------------------

phys_opt_design
write_checkpoint -force post_route_opt_design.dcp
report_timing_summary -file post_route_opt_design_timing_summary.rpt

# ------------------------------------------------------------------------------
# Generate Bitstream
# ------------------------------------------------------------------------------

write_bitstream -force -file bitstream.bit
write_debug_probes -force -file vio_probe.ltx
