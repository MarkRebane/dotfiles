#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="neovide"
PACKAGE_VERSION="0.15.2"
INSTALL_EXE="$HOME/.local/bin/$PACKAGE_NAME"

SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR/$PACKAGE_NAME"
pushd "$SOURCE_DIR/$PACKAGE_NAME"

wget https://github.com/neovide/neovide/releases/download/$PACKAGE_VERSION/neovide-linux-x86_64.tar.gz
tar xf neovide-linux-x86_64.tar.gz
mv neovide "$INSTALL_EXE"
chmod u+x "$INSTALL_EXE"

popd
rm -r "$SOURCE_DIR/$PACKAGE_NAME"

