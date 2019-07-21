set_property SRC_FILE_INFO {cfile:/home/oyaji/work/fpga/boards/arty_A7-35T/xdc/arty_osc.xdc rfile:../../../../../boards/arty_A7-35T/xdc/arty_osc.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:/home/oyaji/work/fpga/boards/arty_A7-35T/xdc/arty_hid.xdc rfile:../../../../../boards/arty_A7-35T/xdc/arty_hid.xdc id:2} [current_design]
set_property SRC_FILE_INFO {cfile:/home/oyaji/work/fpga/boards/arty_A7-35T/xdc/arty_board.xdc rfile:../../../../../boards/arty_A7-35T/xdc/arty_board.xdc id:3} [current_design]
set_property src_info {type:XDC file:1 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports gclk100]; #IO_L12P_T1_MRCC_35 Sch=gclk100
set_property src_info {type:XDC file:1 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter gclk100 0.050;
set_property src_info {type:XDC file:2 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN C2} [get_ports rstb]; #IO_L16P_T2_35 Sch=ck_rst
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN D9} [get_ports btn0]; #IO_L6N_T0_VREF_16 Sch=btn[0]
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN C9} [get_ports btn1]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
set_property src_info {type:XDC file:2 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN B9} [get_ports btn2]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
set_property src_info {type:XDC file:2 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN B8} [get_ports btn3]; #IO_L12P_T1_MRCC_16 Sch=btn[3]
set_property src_info {type:XDC file:2 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports btn0];
set_property src_info {type:XDC file:2 line:16 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports btn1];
set_property src_info {type:XDC file:2 line:17 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports btn2];
set_property src_info {type:XDC file:2 line:18 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports btn3];
set_property src_info {type:XDC file:2 line:23 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN A8} [get_ports sw0]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
set_property src_info {type:XDC file:2 line:24 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN C11} [get_ports sw1]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
set_property src_info {type:XDC file:2 line:25 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN C10} [get_ports sw2]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
set_property src_info {type:XDC file:2 line:26 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN A10} [get_ports sw3]; #IO_L14P_T2_SRCC_16 Sch=sw[3]
set_property src_info {type:XDC file:2 line:28 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports sw0];
set_property src_info {type:XDC file:2 line:29 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports sw1];
set_property src_info {type:XDC file:2 line:30 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports sw2];
set_property src_info {type:XDC file:2 line:31 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -from [get_ports sw3];
set_property src_info {type:XDC file:2 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN E1} [get_ports led0_b]; #IO_L18N_T2_35 Sch=led0_b
set_property src_info {type:XDC file:2 line:37 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN F6} [get_ports led0_g]; #IO_L19N_T3_VREF_35 Sch=led0_g
set_property src_info {type:XDC file:2 line:38 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN G6} [get_ports led0_r]; #IO_L19P_T3_35 Sch=led0_r
set_property src_info {type:XDC file:2 line:39 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN G4} [get_ports led1_b]; #IO_L20P_T3_35 Sch=led1_b
set_property src_info {type:XDC file:2 line:40 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN J4} [get_ports led1_g]; #IO_L21P_T3_DQS_35 Sch=led1_g
set_property src_info {type:XDC file:2 line:41 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN G3} [get_ports led1_r]; #IO_L20N_T3_35 Sch=led1_r
set_property src_info {type:XDC file:2 line:42 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN H4} [get_ports led2_b]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property src_info {type:XDC file:2 line:43 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN J2} [get_ports led2_g]; #IO_L22N_T3_35 Sch=led2_g
set_property src_info {type:XDC file:2 line:44 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN J3} [get_ports led2_r]; #IO_L22P_T3_35 Sch=led2_r
set_property src_info {type:XDC file:2 line:45 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN K2} [get_ports led3_b]; #IO_L23P_T3_35 Sch=led3_b
set_property src_info {type:XDC file:2 line:46 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN H6} [get_ports led3_g]; #IO_L24P_T3_35 Sch=led3_g
set_property src_info {type:XDC file:2 line:47 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN K1} [get_ports led3_r]; #IO_L23N_T3_35 Sch=led3_r
set_property src_info {type:XDC file:2 line:52 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN H5} [get_ports led4]; #IO_L24N_T3_35 Sch=led[4]
set_property src_info {type:XDC file:2 line:53 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN J5} [get_ports led5]; #IO_25_35 Sch=led[5]
set_property src_info {type:XDC file:2 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN T9} [get_ports led6]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
set_property src_info {type:XDC file:2 line:55 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN T10} [get_ports led7]; #IO_L24N_T3_A00_D16_14 Sch=led[7]
set_property src_info {type:XDC file:3 line:19 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS33 [get_ports -filter { LOC =~ IOB_* } ]
set_property src_info {type:XDC file:3 line:24 export:INPUT save:INPUT read:READ} [current_design]
set_operating_conditions -airflow 0
set_property src_info {type:XDC file:3 line:25 export:INPUT save:INPUT read:READ} [current_design]
set_operating_conditions -heatsink low
