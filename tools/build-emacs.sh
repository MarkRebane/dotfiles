#!/usr/bin/env bash
set -euxo pipefail

PACKAGE_NAME="emacs"

# NOTE: Emacs MUST be build in the source tree.
SOURCE_DIR="$HOME/source/tools"
mkdir -p "$SOURCE_DIR"

if [ -d "$SOURCE_DIR/$PACKAGE_NAME" ]; then
    pushd "$SOURCE_DIR/$PACKAGE_NAME"
    make clean
    git pull --rebase
    popd
else
    pushd "$SOURCE_DIR"
    git clone git://git.savannah.gnu.org/emacs.git "$PACKAGE_NAME"
    popd
fi

pushd "$SOURCE_DIR/$PACKAGE_NAME"

export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./autogen.sh && ./configure \
    --with-native-compilation=aot \
    --with-pgtk \
    --with-x-toolkit=gtk3 \
    --with-tree-sitter \
    --with-wide-int \
    --with-json \
    --with-gnutls \
    --with-mailutils \
    --without-pop \
    --with-cairo \
    --with-imagemagick \
    --with-xwidgets \
    --with-gif \
    --with-png \
    --with-jpeg \
    --with-rsvg \
    --with-tiff \
    --prefix=$HOME/.local/emacs \
    CFLAGS='-O2 -pipe -mtune=native -march=native -fomit-frame-pointer -ftree-loop-vectorize'

make -j$(nproc) NATIVE_FULL_AOT=1
make install

popd
