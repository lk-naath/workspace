#!/bin/bash

set -euo pipefail

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

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

os="${1:-}"
if [[ -z "$os" ]]; then
	case "$(uname -s)" in
		Darwin) os=mac ;;
		Linux) os=linux ;;
		*) echo "Unsupported operating system: $(uname -s)" >&2; exit 1 ;;
	esac
fi

case "$os" in
	mac) install_nvim_mac ;;
	linux) install_nvim_linux ;;
	*) echo "Unknown operating system: $os (use mac or linux)." >&2; exit 2 ;;
esac

config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# Sync repository configuration while preserving user-created config files.
mkdir -p "$config_dir"
rm -f "$config_dir/lua/plugins/colorscheme/kanagawa.lua"
cp -R "$repo_root/nvim/." "$config_dir/"
cp "$repo_root/config.toml" "$config_dir/config.toml"

echo "Installed Neovim config in $config_dir."
