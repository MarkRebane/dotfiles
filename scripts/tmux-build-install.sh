#!/usr/bin/env bash
set -e # abort script on error

## Prerequisites ###############################################################

# 1. Install dependencies
#  $ sudo apt -y install libevent-dev libncurses5-dev libutempter-dev \
#    autoconf automake pkg-config 

## Script Install ##############################################################

tmux_dir="${HOME}/source/tools/tmux"
if [ -d ${tmux_dir} ]; then
    echo "git pull ${tmux_dir}..."
    cd ${tmux_dir}
    git pull --rebase
else
    mkdir -p ${tmux_dir} && cd ${tmux_dir}
    echo "git clone --recursive ${tmux_dir}..."
    git clone --recursive https://github.com/tmux/tmux.git ${tmux_dir}
    cd ${tmux_dir}
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
