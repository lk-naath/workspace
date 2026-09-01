#!/bin/bash

set -euo pipefail

setup_mac() { brew install neovim; }

setup_linux() {
  sudo apt remove -y neovim
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
  chmod u+x nvim.appimage
  ./nvim.appimage
  rm -f nvim.appimage
}

case "${1:-linux}" in
  mac) setup_mac ;;
  linux) setup_linux ;;
  *) exit 1 ;;
esac

./nvim/setup.sh
