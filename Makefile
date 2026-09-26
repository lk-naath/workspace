.DEFAULT_GOAL := help
.PHONY: help setup install uninstall nvim mac linux iterm2

SHELL := /bin/bash
WORKSPACE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
XDG_CONFIG_HOME ?= $(HOME)/.config
ITERM2_AUTOLAUNCH_DIR ?= $(HOME)/Library/Application Support/iTerm2/Scripts/AutoLaunch

help:
	@echo "make setup nvim        Install Neovim and its config for this OS"
	@echo "make setup nvim mac    Install Neovim and its config for macOS"
	@echo "make setup nvim linux  Install Neovim and its config for Linux"
	@echo "make setup iterm2      Install iTerm2 and its terminal configuration"
	@echo "make install iterm2    Install iTerm2 and this workspace plugin"
	@echo "make uninstall iterm2  Remove the workspace iTerm2 plugin"
	@echo ""
	@echo "Override paths with XDG_CONFIG_HOME=... or ITERM2_AUTOLAUNCH_DIR=..."

# GNU Make treats trailing words as goals; pass them to the command script.
setup install uninstall:
	@target="$(filter-out $@,$(MAKECMDGOALS))"; \
	WORKSPACE_DIR="$(WORKSPACE_DIR)" XDG_CONFIG_HOME="$(XDG_CONFIG_HOME)" \
		ITERM2_AUTOLAUNCH_DIR="$(ITERM2_AUTOLAUNCH_DIR)" \
		bash "$(WORKSPACE_DIR)/setup.sh" "$@" $$target

nvim mac linux iterm2:
	@:
