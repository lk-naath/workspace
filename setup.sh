#!/bin/bash

apt remove neovim \
  && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
  && chmod u+x nvim.appimage \
  && ./nvim.appimage \
  && ./nvim/setup.sh \
  && rm nvim.appimage
# rm -rf ~/.config/nvim
# git clone https://github.com/LazyVim/starter ~/.config/nvim
