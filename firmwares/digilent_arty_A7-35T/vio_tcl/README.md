Generate debug core on the fly.

# Overview

Creates from TCL commands a VIO debug core instances, configures this core to match human input/output interface (LEDs; buttons and switches).

# Usage

```
$ PATH=$PATH:<vivado bin directory> make
$ PATH=$PATH:<vivado bin directory> make program
```

Best is to use the GUI for loading the vio_probe.ltx in the hardware device manager and play around.

Build files are removed by calling the clean rule.

```
$ make clean
```
