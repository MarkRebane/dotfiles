#!/usr/bin/env bash
set -e # abort script on error

## Prerequisites ###############################################################

# 1. Install dependencies
#  $ sudo apt -y install libevent-dev libncurses5-dev libutempter-dev \
#    autoconf automake pkg-config 

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
echo "Cleaning-up previous build..."
make distclean
echo "Configuring..."
./configure --enable-utempter
echo "make..."
make -j$(($(nproc)+1))
echo "make install..."
sudo make install
