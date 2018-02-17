################################################################################
# Digilent Arty HID Pin and Timing Constraints
################################################################################

################################################################################
# Buttons

set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports rst]; #IO_L16P_T2_35 Sch=ck_rst
set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports btn0]; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS33} [get_ports btn1]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property -dict {PACKAGE_PIN B9 IOSTANDARD LVCMOS33} [get_ports btn2]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVCMOS33} [get_ports btn3]; #IO_L12P_T1_MRCC_16 Sch=btn[3]

set_false_path -from [get_ports rst];
set_false_path -from [get_ports btn0];
set_false_path -from [get_ports btn1];
set_false_path -from [get_ports btn2];
set_false_path -from [get_ports btn3];

################################################################################
# Switches

set_property -dict {PACKAGE_PIN A8 IOSTANDARD LVCMOS33} [get_ports sw0]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property -dict {PACKAGE_PIN C11 IOSTANDARD LVCMOS33} [get_ports sw1]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
set_property -dict {PACKAGE_PIN C10 IOSTANDARD LVCMOS33} [get_ports sw2]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
set_property -dict {PACKAGE_PIN A10 IOSTANDARD LVCMOS33} [get_ports sw3]; #IO_L14P_T2_SRCC_16 Sch=sw[3]

set_false_path -from [get_ports sw0];
set_false_path -from [get_ports sw1];
set_false_path -from [get_ports sw2];
set_false_path -from [get_ports sw3];

################################################################################
# RGB LEDs

set_property -dict {PACKAGE_PIN E1 IOSTANDARD LVCMOS33} [get_ports led0_b]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports led0_g]; #IO_L19N_T3_VREF_35 Sch=led0_g
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports led0_r]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports led1_b]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports led1_g]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports led1_r]; #IO_L20N_T3_35 Sch=led1_r
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports led2_b]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports led2_g]; #IO_L22N_T3_35 Sch=led2_g
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports led2_r]; #IO_L22P_T3_35 Sch=led2_r
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports led3_b]; #IO_L23P_T3_35 Sch=led3_b
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports led3_g]; #IO_L24P_T3_35 Sch=led3_g
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports led3_r]; #IO_L23N_T3_35 Sch=led3_r

################################################################################
# LEDs

set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports led4]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports led5]; #IO_25_35 Sch=led[5]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports led6]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports led7]; #IO_L24N_T3_A00_D16_14 Sch=led[7]
