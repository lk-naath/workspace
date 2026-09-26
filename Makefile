.DEFAULT_GOAL := help
.PHONY: help setup install uninstall nvim mac linux iterm2

SHELL := /bin/bash
WORKSPACE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
XDG_CONFIG_HOME ?= $(HOME)/.config
ITERM2_AUTOLAUNCH_DIR ?= $(HOME)/Library/Application Support/iTerm2/Scripts/AutoLaunch

help:
	@echo "make install nvim      Install Neovim and sync its config for this OS"
	@echo "make install nvim mac  Install Neovim and sync its config for macOS"
	@echo "make install nvim linux Install Neovim and sync its config for Linux"
	@echo "make install iterm2    Install iTerm2 and this workspace plugin"
	@echo "make uninstall nvim    Remove the Neovim config (keeps Neovim installed)"
	@echo "make uninstall iterm2  Remove the workspace iTerm2 plugin"
	@echo ""
	@echo "Override paths with XDG_CONFIG_HOME=... or ITERM2_AUTOLAUNCH_DIR=..."

# GNU Make treats trailing words as goals; route install/uninstall to each app.
install uninstall:
	@target="$(word 2,$(MAKECMDGOALS))"; \
	platform="$(word 3,$(MAKECMDGOALS))"; \
	action="$(firstword $(MAKECMDGOALS))"; \
	[[ "$$action" == setup ]] && action=install; \
	case "$$action:$$target" in \
		install:nvim) WORKSPACE_DIR="$(WORKSPACE_DIR)" XDG_CONFIG_HOME="$(XDG_CONFIG_HOME)" bash "$(WORKSPACE_DIR)/nvim/install.sh" "$$platform" ;; \
		install:iterm2) WORKSPACE_DIR="$(WORKSPACE_DIR)" ITERM2_AUTOLAUNCH_DIR="$(ITERM2_AUTOLAUNCH_DIR)" bash "$(WORKSPACE_DIR)/iterm2/install.sh" ;; \
		uninstall:nvim) WORKSPACE_DIR="$(WORKSPACE_DIR)" XDG_CONFIG_HOME="$(XDG_CONFIG_HOME)" bash "$(WORKSPACE_DIR)/nvim/uninstall.sh" ;; \
		uninstall:iterm2) WORKSPACE_DIR="$(WORKSPACE_DIR)" ITERM2_AUTOLAUNCH_DIR="$(ITERM2_AUTOLAUNCH_DIR)" bash "$(WORKSPACE_DIR)/iterm2/uninstall.sh" ;; \
		*) echo "Usage: make {install|uninstall} {nvim [mac|linux]|iterm2}" >&2; exit 2 ;; \
	esac

# Retain setup as an alias for install for existing workflows.
setup: install

nvim mac linux iterm2:
	@:
