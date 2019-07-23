# ------------------------------------------------------------------------------

BUILD_DIR = build
VIVADO_BATCH = vivado \
	-log $(BUILD_DIR)/vivado.log -jou $(BUILD_DIR)/vivado.jou \
	-mode batch -source

.PHONY: all check program clean

# default target
all: check $(BUILD_DIR) \
	$(BUILD_DIR)/synth_design.dcp $(BUILD_DIR)/opt_design.dcp \
	$(BUILD_DIR)/place_design.dcp $(BUILD_DIR)/post_place_opt_design.dcp \
	$(BUILD_DIR)/route_design.dcp $(BUILD_DIR)/post_route_opt_design.dcp \
	$(BUILD_DIR)/bitstream.bit

check:
	@type vivado >& /dev/null || (echo "'vivado' executable not found"; exit 1)

$(BUILD_DIR):
	-mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/synth_design.dcp:
	$(VIVADO_BATCH) synth_design.tcl

$(BUILD_DIR)/opt_design.dcp:
	$(VIVADO_BATCH) opt_design.tcl

$(BUILD_DIR)/place_design.dcp:
	$(VIVADO_BATCH) place_design.tcl

$(BUILD_DIR)/post_place_opt_design.dcp:
	$(VIVADO_BATCH) post_place_opt_design.tcl

$(BUILD_DIR)/route_design.dcp:
	$(VIVADO_BATCH) route_design.tcl

$(BUILD_DIR)/post_route_opt_design.dcp:
	$(VIVADO_BATCH) post_route_opt_design.tcl

$(BUILD_DIR)/bitstream.bit:
	$(VIVADO_BATCH) generate_bitstream.tcl

program: $(BUILD_DIR)/bitstream.bit
	$(VIVADO_BATCH) program.tcl

clean:
	-rm -rf ./$(BUILD_DIR)/ ./.Xil/ ./vivado.log ./vivado.jou
