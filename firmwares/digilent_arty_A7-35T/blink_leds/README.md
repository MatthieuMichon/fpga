Blink all LEDs

# Overview

Go through all the steps (include optimization steps) for generating the configuration data bits binary stream (also simply called ``bitstream``) configuration file.

The makefile provides a stand-alone target rule for uploading the bitstream to the FPGA and reconfigure-it.

# Usage

```
$ PATH=$PATH:<vivado bin directory> make
$ PATH=$PATH:<vivado bin directory> make program
```

Build files are removed by calling the clean rule.

```
$ make clean
```

# Notes

After Loading design checkpoint files (using the ``read_checkpoint``  command), in-memory design elements must be updated before continuing the build process. This is accomplished using the ``link_design`` command.
