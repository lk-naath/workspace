#!/bin/bash

set -euo pipefail

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

install_config() {
	WORKSPACE_DIR="$repo_root" XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}" \
		bash "$repo_root/nvim/loader.sh"
}

install_nvim_mac() {
	command -v brew >/dev/null 2>&1 || {
		echo "Homebrew is required to install Neovim on macOS." >&2
		return 1
	}
	brew install neovim
}

install_nvim_linux() {
	command -v apt-get >/dev/null 2>&1 || {
		echo "Unsupported Linux package manager; install Neovim manually." >&2
		return 1
	}
	sudo apt-get update
	sudo apt-get install -y neovim
}

setup_nvim() {
	local os="${2:-}"
	if [[ -z "$os" ]]; then
		case "$(uname -s)" in
			Darwin) os=mac ;;
			Linux) os=linux ;;
			*) echo "Unsupported operating system: $(uname -s)" >&2; return 1 ;;
		esac
	fi

	case "$os" in
		mac) install_nvim_mac ;;
		linux) install_nvim_linux ;;
		*) echo "Unknown operating system: $os (use mac or linux)." >&2; return 2 ;;
	esac

	install_config
}

setup_iterm2() {
	[[ "$(uname -s)" == "Darwin" ]] || {
		echo "iTerm2 setup is available only on macOS." >&2
		return 1
	}

	# Install the host application when Homebrew is available; configuration
	# still runs independently for users who manage iTerm2 themselves.
	if command -v brew >/dev/null 2>&1; then
		brew install --cask iterm2
	fi

	WORKSPACE_DIR="$repo_root" ITERM2_AUTOLAUNCH_DIR="${ITERM2_AUTOLAUNCH_DIR:-$HOME/Library/Application Support/iTerm2/Scripts/AutoLaunch}" \
		bash "$repo_root/iterm2/loader.sh"
}

case "${1:-nvim}" in
	nvim) setup_nvim "$@" ;;
	iterm2) setup_iterm2 ;;
	*) echo "Usage: make setup {nvim [mac|linux]|iterm2}" >&2; exit 2 ;;
esac
