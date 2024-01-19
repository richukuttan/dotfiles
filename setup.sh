#!/bin/bash

apt update
apt full-upgrade
do-release-upgrade

apt install zsh git fonts-font-awesome
apt install neovim
apt install python3 python3-pip

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

ln -s $scriptDir/zsh/.zshrc ~/.zshrc
ln -s $scriptDir/zsh/.zshenv ~/.zshenv
ln -s $scriptDir/.config ~/.config

chsh -s "$(which zsh)"