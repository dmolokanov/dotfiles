#!/bin/bash

# shellcheck source=distro.sh
. ../distro.sh
# shellcheck source=helpers.sh
. ../helpers.sh

#echo_info "Installing Git LFS..."
#brew install git-lfs

echo_info "Symlink ~/.gitconfig"
ln -sf "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"

echo_done "Git configuration!"
