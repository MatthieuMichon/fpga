################################################################################
# Digilent Arty Clock Pin and Timing Constraints
################################################################################

################################################################################
# Clock Oscillator reference: ASEM1-100.000MHZ-LC-T

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports gclk100]; #IO_L12P_T1_MRCC_35 Sch=gclk100
create_clock -add -name gclk100 -period 10 [get_ports { gclk100 }];
set_input_jitter gclk100 0.050;
