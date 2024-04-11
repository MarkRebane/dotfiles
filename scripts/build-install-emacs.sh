#!/usr/bin/env bash
set -euxo pipefail

# NOTE: Emacs MUST be build in the source tree.
emacs_dir="${HOME}/source/tools/emacs"
if [ -d "${emacs_dir}" ]; then
    echo "git pull ${emacs_dir}..."
    cd "${emacs_dir}"
    make clean
    git pull --rebase
else
    mkdir -p "${emacs_dir}" && cd "${emacs_dir}"
    echo "git clone ${emacs_dir}..."
    git clone git://git.savannah.gnu.org/emacs.git "${emacs_dir}"
    cd "${emacs_dir}"
fi

export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./autogen.sh && ./configure \
    --with-native-compilation \
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
    --prefix=${HOME}/.local/emacs \
    CFLAGS='-O2 -pipe -mtune=native -march=native -fomit-frame-pointer -ftree-loop-vectorize'

make -j$(nproc) NATIVE_FULL_AOT=1
make install

