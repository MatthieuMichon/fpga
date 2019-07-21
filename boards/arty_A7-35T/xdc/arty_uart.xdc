################################################################################
# Digilent Arty UART Pin and Timing Constraints
################################################################################

################################################################################
# UART

set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports uart_rxd_out]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVCMOS33} [get_ports uart_txd_in]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

set_false_path -from [get_ports uart_txd_in];
