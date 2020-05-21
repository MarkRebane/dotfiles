#!/bin/sh
set -e

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

## Script Install ##############################################################

source_dir="${HOME}/source/tools/tmux"
if [ -d "${source_dir}" ]; then
    cd "${source_dir}"
    git pull --rebase
else
    mkdir -p "${source_dir}" && cd "${source_dir}"
    git clone --recursive https://github.com/tmux/tmux.git "${source_dir}"
    cd "${source_dir}"
fi

./autogen.sh
./configure \
    --enable-utempter \
    --prefix="${HOME}"/.local/tmux
make -j$(($(nproc)-1))
make install
