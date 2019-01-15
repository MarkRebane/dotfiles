#!/usr/bin/env bash
set -e # abort script on error

## Prerequisites ###############################################################

# 1. Install dependencies
#  $ sudo apt -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
#    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev \
#    libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.3 \
#    liblua5.3-dev libperl-dev git libgpm-dev gpm cmake

# 2. Create Symlinks if lua 5.3 isn't detected
#  $ sudo ln -s /usr/include/lua5.3 /usr/local/include/lua
#  $ sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.3.so /usr/local/lib/liblua.so
#  $ sudo ln -s /usr/bin/lua5.3 /usr/local/bin/lua

# 3. Remove old vim installs
#  $ sudo apt -y remove vim vim-runtime gvim && \
#    sudo apt -y autoremove && \
#    sudo apt -y autoclean

## Script Install ##############################################################

vim_dir="${HOME}/source/tools/vim"
if [ -d ${vim_dir} ]; then
    echo "git pull ${vim_dir}..."
    cd ${vim_dir}
    git pull --rebase
else
    mkdir -p ${vim_dir} && cd ${vim_dir}
    echo "git clone --recursive ${vim_dir}..."
    git clone --recursive https://github.com/vim/vim.git ${vim_dir}
    cd ${vim_dir}
fi

# TODO if these don't exist, look for environment variables,
# and if those don't exist, error
python2_config="/usr/lib/python2.7/config-x86_64-linux-gnu"
python3_config="/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu"
lua_prefix="/usr"
if [ ! -d ${python2_config} ]; then
    echo "Error! Python2 config not found: ${python2_config}"
    exit 1
fi
if [ ! -d ${python3_config} ]; then
    echo "Error! Python3 config not found: ${python3_config}"
    python3_config="/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
    if [ ! -d ${python3_config} ]; then
        echo "Error! Python3 config not found: ${python3_config}"
        exit 1
    else
        echo "Falling back to: ${python3_config}"
    fi
fi
if [ ! -d ${lua_prefix} ]; then
    echo "Error! Lua prefix directory not found: ${lua_prefix}"
    exit 1
fi

echo "Cleaning-up previous build..."
make distclean
echo "Configuring..."
./configure --with-features=huge \
    --enable-cscope \
    --enable-gpm \
    --enable-gui=gtk2 \
    --enable-largefile \
    --enable-multibyte \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-perlinterp=yes \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --with-lua_prefix=${lua_prefix} \
    --with-python-config-dir=${python2_config} \
    --with-python3-config-dir=${python3_config} \
    --enable-fail-if-missing \
    --prefix=${HOME}/.local/vim

echo "make..."
make -j$(($(nproc)+1)) VIMRUNTIMEDIR=${HOME}/.local/vim/share/vim/vim81
echo "make install..."
sudo make install
