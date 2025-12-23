#!/usr/bin/env bash
set -e

PACKAGE_NAME="tree-sitter"
PACKAGE_VERSION_MAJOR="0.25"
PACKAGE_VERSION_PATCH="10"

SOURCE_DIR="$HOME/source/tools"
BUILD_DIR="$HOME/build/tools"
INSTALL_PREFIX="$HOME/.local/$PACKAGE_NAME"

mkdir -p "$SOURCE_DIR"
if [ -d "$SOURCE_DIR/$PACKAGE_NAME" ]; then
    pushd "$SOURCE_DIR/$PACKAGE_NAME"
    git pull --rebase
    popd
else
    pushd "$SOURCE_DIR"
    git clone --recursive -b "release-$PACKAGE_VERSION_MAJOR" --single-branch https://github.com/tree-sitter/tree-sitter "$PACKAGE_NAME"
    popd
fi

mkdir -p "$BUILD_DIR/$PACKAGE_NAME"
pushd "$BUILD_DIR/$PACKAGE_NAME"

cmake \
    -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX:PATH="$INSTALL_PREFIX" \
    "$SOURCE_DIR/$PACKAGE_NAME"

make -j12
make install

wget https://github.com/tree-sitter/tree-sitter/releases/download/v$PACKAGE_VERSION_MAJOR\.$PACKAGE_VERSION_PATCH/tree-sitter-linux-x64.gz
gunzip tree-sitter-linux-x64.gz
mkdir -p "$INSTALL_PREFIX/bin"
mv tree-sitter-linux-x64 "$INSTALL_PREFIX/bin/$PACKAGE_NAME-cli"
chmod u+x "$INSTALL_PREFIX/bin/$PACKAGE_NAME"

popd
