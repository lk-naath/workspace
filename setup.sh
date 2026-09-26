#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_config() {
	local config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
	mkdir -p "$config_dir"
	cp -R "$repo_root/nvim/." "$config_dir/"
	cp "$repo_root/config.toml" "$config_dir/config.toml"
}

setup_mac() {
	command -v brew >/dev/null 2>&1 || {
		echo "Homebrew is required to install Neovim on macOS." >&2
		return 1
	}
	brew install neovim
	install_config
}

setup_linux() {
	command -v apt-get >/dev/null 2>&1 || {
		echo "Unsupported Linux package manager; install Neovim manually." >&2
		return 1
	}
	sudo apt-get update
	sudo apt-get install -y neovim
	install_config
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
		mac) setup_mac ;;
		linux) setup_linux ;;
		*) echo "Unknown operating system: $os (use mac or linux)." >&2; return 2 ;;
	esac
}

case "${1:-nvim}" in
	nvim) setup_nvim "$@" ;;
	*) echo "Usage: make setup nvim [mac|linux]" >&2; exit 2 ;;
esac
