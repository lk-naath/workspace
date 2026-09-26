#!/bin/bash

set -euo pipefail

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

mkdir -p "$config_dir"
# Remove deleted or unselected theme specs left by earlier installations.
rm -f "$config_dir/lua/plugins/colorscheme/kanagawa.lua"
cp -R "$repo_root/nvim/." "$config_dir/"
cp "$repo_root/config.toml" "$config_dir/config.toml"

echo "Configured Neovim in $config_dir."
