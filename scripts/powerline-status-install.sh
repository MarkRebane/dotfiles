#!/usr/bin/env bash
set -e

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

## Script Install ##############################################################

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.local/share/fonts
mv PowerlineSymbols.otf ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
fc-cache -vf ~/.local/share/fonts/
