# ------------------------------------------------------------------------------

# set output directory
cd ./build

read_checkpoint synth_design.dcp
link_design
opt_design -directive Explore
write_checkpoint -force opt_design.dcp
report_timing_summary -file opt_design_timing_summary.rpt
