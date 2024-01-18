#!/bin/bash

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

ln -s $scriptDir/zsh/.zshrc ~/.zshrc
ln -s $scriptDir/zsh/.zshenv ~/.zshenv

ln -s $scriptDir/.config ~/.config