#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="nvim"

SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR"

if [ -d "$SOURCE_DIR/$PACKAGE_NAME" ]; then
    pushd "$SOURCE_DIR/$PACKAGE_NAME"
    git pull --rebase
    popd
else
    pushd "$SOURCE_DIR"
    git clone --recursive https://github.com/neovim/neovim "$PACKAGE_NAME"
    popd
fi

pushd "$SOURCE_DIR/$PACKAGE_NAME"

make distclean
make deps
make CMAKE_BUILD_TYPE=RelWithDebInfo
make CMAKE_INSTALL_PREFIX="$HOME/.local/nvim" install

popd
