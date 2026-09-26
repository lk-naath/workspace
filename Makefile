.DEFAULT_GOAL := help
.PHONY: help setup nvim mac linux

help:
	@echo "make setup nvim        Install Neovim and its config for this OS"
	@echo "make setup nvim mac    Install Neovim and its config for macOS"
	@echo "make setup nvim linux  Install Neovim and its config for Linux"

# GNU Make treats the words after `setup` as separate goals; pass them together.
setup:
	@bash ./setup.sh $(filter-out $@,$(MAKECMDGOALS))

nvim mac linux:
	@:
