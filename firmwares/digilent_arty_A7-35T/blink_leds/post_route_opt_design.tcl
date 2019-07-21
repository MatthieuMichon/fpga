# ------------------------------------------------------------------------------

# set output directory
cd ./build

read_checkpoint route_design.dcp
link_design
phys_opt_design
write_checkpoint -force post_route_opt_design.dcp
report_timing_summary -file post_route_opt_design_timing_summary.rpt
