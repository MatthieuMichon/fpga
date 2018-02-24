set base_dir ../../../
set board arty
set top_name term_color

set top_path $base_dir/boards/$board/top
set xdc_path $base_dir/boards/$board/xdc
set adlib_path $base_dir/adlib
set bitstream ./$top_name.bit

################################################################################
# import source files

read_xdc $xdc_path/arty_board.xdc
source $xdc_path/arty_board.tcl
read_xdc $xdc_path/arty_osc.xdc
read_xdc $xdc_path/arty_hid.xdc
read_xdc $xdc_path/arty_uart.xdc

read_vhdl $top_path/$top_name/$top_name.vhd
read_vhdl $adlib_path/cdc/sync/sync.vhd
read_xdc -ref {sync} $adlib_path/cdc/sync/sync.xdc
read_vhdl $adlib_path/debouncer/debouncer.vhd
read_vhdl $adlib_path/comm/uart_tx/uart_tx.vhd

################################################################################
# implement design

synth_design \
	-assert \
	-flatten_hierarchy none \
	-top $top_name
# opt_design
# write_checkpoint ./synthesized.dcp

place_design
# phys_opt_design -placement_opt
# write_checkpoint ./placed.dcp

route_design
# phys_opt_design -routing_opt
# write_checkpoint ./routed.dcp

# place_design -post_place_opt 
# phys_opt_design

# route_design
# phys_opt_design -routing_opt

write_bitstream -force $bitstream

################################################################################
# upload bitstream

open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE ./$bitstream [lindex [get_hw_devices] 0]
program_hw_devices [lindex [get_hw_devices] 0]
