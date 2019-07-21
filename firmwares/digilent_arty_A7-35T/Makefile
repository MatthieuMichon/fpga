SUBDIRS = blink_leds

all: $(SUBDIRS)

.PHONY: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean: $(SUBDIRS)
	$(MAKE) -C $@ clean
