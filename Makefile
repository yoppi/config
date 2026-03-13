##
# Update some configuration files(.zshrc, .irbrc, .gitrc, and .vimrc, so on).
#

CONFIG := $(shell pwd)
HOME_DIR := $(HOME)

# dot.* files (not directories) -> ~/.* files
DOT_FILES := $(shell find $(CONFIG) -maxdepth 1 -name 'dot.*' ! -type d)
HOME_FILES := $(patsubst $(CONFIG)/dot.%,$(HOME_DIR)/.%,$(DOT_FILES))

# dot.*/**/* files (inside dot directories) -> ~/.*/**/*
DOT_DIR_FILES := $(shell find $(CONFIG) -mindepth 2 -path '$(CONFIG)/dot.*' -type f)
HOME_DIR_FILES := $(patsubst $(CONFIG)/dot.%,$(HOME_DIR)/.%,$(DOT_DIR_FILES))

ALL_TARGETS := $(HOME_FILES) $(HOME_DIR_FILES)

.PHONY: all clean

all: $(ALL_TARGETS)

# Rule for top-level dot files: ~/.foo <- dot.foo
$(HOME_DIR)/.%: $(CONFIG)/dot.%
	cp $< $@

# Rule for files inside dot directories: ~/.foo/bar <- dot.foo/bar
# Ensure target directory exists
$(HOME_DIR)/.%:
	@mkdir -p $(dir $@)
	cp $(CONFIG)/dot.$* $@

clean:
