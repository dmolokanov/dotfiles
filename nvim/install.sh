#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

echo_info "Installling Neovim..."
brew install neovim

echo_info "Installing vim-plug..."
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo_info "Symling init.vim..."
mkdir -p ~/.config/nvim
ln -sf ~/.dotfiles/nvim/init.vim ~/.config/nvim/init.vim

echo_done "Neovim configuration!"
