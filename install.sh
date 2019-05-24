#!/bin/bash

. distro.sh
. helpers.sh

which -s brew
if [[ $? != 0 ]]; then
  echo_info "Install Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo_info "Update Homebrew"
  brew update
fi

echo_info "Installing dotfiles"
dirs=$(find . -maxdepth 1 -mindepth 1 -type d -not -name '.git' -print)
for dir in $dirs; do
  echo "Installing ${dir}..."
  cd "$dir" || exit
  ./install.sh
  cd ..
done
