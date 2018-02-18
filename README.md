FPGA related repo

# Firmware Projects

|Name|Board|Description|
|---|---|---|
|arty_led|Digilent Arty A7-35T|LED4 on when 200 MHz PLL locks|

# Usage

* ``cd ./firmware``
* ``./run <name>``

# Notes

* Vivado binaries directory ``Vivado/<version>/bin`` must be visible from the script.
* The script in ``./firmware`` generates a bitstream and uploads it in the board attached to the host.
