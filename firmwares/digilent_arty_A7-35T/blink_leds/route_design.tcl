# ------------------------------------------------------------------------------

# set output directory
cd ./build

read_checkpoint post_place_opt_design.dcp
link_design
route_design
write_checkpoint -force route_design.dcp
report_timing_summary -file route_design_timing_summary.rpt
