#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

#echo_info "Installing Git LFS..."
#brew install git-lfs

echo_info "Symlink ~/.config/alacritty/alacritty.yaml"
ln -sf "$HOME/.dotfiles/alacritty/alacritty.yaml" "$HOME/.config/alacritty/alacritty.yaml"

echo_done "alacritty configuration!"
