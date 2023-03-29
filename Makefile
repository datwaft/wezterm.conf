FC := fennel
FFLAGS := --add-fennel-path 'fnl/?.fnl' \
					--add-macro-path 'fnl/?.fnl'
SRC_DIR := fnl
TARGET := wezterm.lua

all: $(TARGET)

%.lua: $(SRC_DIR)/%.fnl
	$(FC) $(FFLAGS) -c $< > $@
