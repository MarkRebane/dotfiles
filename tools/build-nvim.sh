#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="nvim"
INSTALL_DIR="$HOME/.local/$PACKAGE_NAME"

SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR/$PACKAGE_NAME"
pushd "$SOURCE_DIR/$PACKAGE_NAME"



wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
rm -rf "$INSTALL_DIR"
mv nvim-linux-x86_64 "$INSTALL_DIR"

popd
rm -rf "$SOURCE_DIR/$PACKAGE_NAME"
