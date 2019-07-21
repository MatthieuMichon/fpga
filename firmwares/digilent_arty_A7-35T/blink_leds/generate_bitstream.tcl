# ------------------------------------------------------------------------------

# set output directory
cd ./build

read_checkpoint post_route_opt_design.dcp
link_design
write_bitstream -force -file bitstream.bit