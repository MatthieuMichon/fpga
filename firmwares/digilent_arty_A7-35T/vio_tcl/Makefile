# ------------------------------------------------------------------------------

BUILD_DIR = ./build/
VIVADO_BATCH = \
	vivado \
	-log $(BUILD_DIR)/vivado.log \
	-jou $(BUILD_DIR)/vivado.jou \
	-mode batch -source

.PHONY: all check build program clean

# default target
all: check build $(BUILD_DIR)/bitstream.bit

check:
	@type vivado >& /dev/null || (echo "'vivado' executable not found"; exit 1)

$(BUILD_DIR):
	-mkdir -p $(BUILD_DIR)

build: $(BUILD_DIR)
	$(VIVADO_BATCH) build.tcl

program: $(BUILD_DIR)/bitstream.bit
	$(VIVADO_BATCH) program.tcl

clean:
	-rm -rf ./$(BUILD_DIR)/ ./.Xil/ ./vivado.log ./vivado.jou
