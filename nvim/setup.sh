#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$HOME/.config/nvim"
cp -R "$repo_root/nvim/." "$HOME/.config/nvim/"
cp "$repo_root/config.toml" "$HOME/.config/nvim/config.toml"
