# ------------------------------------------------------------------------------

# set output directory
cd ./build

read_checkpoint opt_design.dcp
link_design
place_design -directive Explore
write_checkpoint -force place_design.dcp
report_timing_summary -file place_design_timing_summary.rpt
