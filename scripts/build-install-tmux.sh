#!/usr/bin/env bash
set -e # abort script on error

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

## Script Install ##############################################################

source_dir="${HOME}/source/tools/tmux"
if [ -d ${source_dir} ]; then
    echo "git pull ${source_dir}..."
    cd ${source_dir}
    git pull --rebase
else
    mkdir -p ${source_dir} && cd ${source_dir}
    echo "git clone --recursive ${source_dir}..."
    git clone --recursive https://github.com/tmux/tmux.git ${source_dir}
    cd ${source_dir}
fi

echo "Autogen..."
sh autogen.sh
echo "Configuring..."
./configure --enable-utempter
echo "make..."
make -j$(($(nproc)-1))
echo "make install..."
sudo make install
