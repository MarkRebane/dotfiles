#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="vim"

SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR"

if [ -d "$SOURCE_DIR/$PACKAGE_NAME" ]; then
    pushd "$SOURCE_DIR/$PACKAGE_NAME"
    git pull --rebase
    popd
else
    pushd "$SOURCE_DIR"
    git clone --recursive https://github.com/vim/vim.git "$PACKAGE_NAME"
    popd
fi

pushd "$SOURCE_DIR/$PACKAGE_NAME"

make distclean
./configure \
    --with-features=huge \
    --enable-cscope \
    --enable-gpm \
    --enable-gui=gtk2 \
    --enable-largefile \
    --enable-multibyte \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-perlinterp=yes \
    --enable-python2interp=yes \
    --enable-python3interp=yes \
    --enable-fail-if-missing \
    --prefix="$HOME/.local/vim"

make -j$(($(nproc)-1)) VIMRUNTIMEDIR="$HOME/.local/vim/share/vim/vim91"
make install

popd
