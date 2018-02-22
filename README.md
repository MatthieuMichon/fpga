FPGA related repo

# Firmware Projects

|Name|Board|Description|
|---|---|---|
|arty_led|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|LED4 on when 200 MHz PLL locks|
|arty_uart_loopback|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|UART loopback (on ``ttyUSB1``)|
|arty_button_uart_tx|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|Transmit char ``A`` (on ``ttyUSB1``) when btn0 is pressed|
|arty_string_uart|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|Transmit a string ``this is a test`` (on ``ttyUSB1``) when btn0 is pressed|
|arty_pll_torrent|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|Serial linkage of all five MMCMs pand five PLLs|

# Usage

* ``cd ./firmware``
* ``./run <name>``

# Notes

* Vivado binaries directory (``Vivado/<version>/bin``) must be visible from the script.
* The script in ``./firmware`` generates a bitstream and uploads it in the board attached to the host.
