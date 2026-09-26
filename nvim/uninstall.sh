#!/bin/bash

set -euo pipefail

repo_root="${WORKSPACE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

source "$repo_root/utils.sh"
confirm_delete "$config_dir"
echo "Removed the Neovim config. The Neovim application and its data directory were left in place."
