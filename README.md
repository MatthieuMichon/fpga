FPGA related repo

# Firmware Projects

|Name|Board|Description|
|---|---|---|
|arty_led|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|LED4 on when 200 MHz PLL locks|
|arty_uart_loopback|[Digilent Arty A7-35T](https://store.digilentinc.com/arty-a7-artix-7-fpga-development-board-for-makers-and-hobbyists/)|UART loopback (on ``ttyUSB1``)|

# Usage

* ``cd ./firmware``
* ``./run <name>``

# Notes

* Vivado binaries directory (``Vivado/<version>/bin``) must be visible from the script.
* The script in ``./firmware`` generates a bitstream and uploads it in the board attached to the host.
