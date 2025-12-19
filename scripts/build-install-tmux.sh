#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="tmux"

SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR"

if [ -d "$SOURCE_DIR/$PACKAGE_NAME" ]; then
    pushd "$SOURCE_DIR/$PACKAGE_NAME"
    git pull --rebase
    popd
else
    pushd "$SOURCE_DIR"
    git clone --recursive https://github.com/tmux/tmux.git "$PACKAGE_NAME"
    popd
fi

pushd "$SOURCE_DIR/$PACKAGE_NAME"

./autogen.sh
./configure \
    --enable-utempter \
    --prefix="$HOME/.local/tmux"
make -j$(($(nproc)-1))
make install

popd
