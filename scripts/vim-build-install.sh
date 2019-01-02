#!/usr/bin/env bash
set -e # abort script on error

## Prerequisites ###############################################################

# 1. Install dependencies
#  $ sudo apt -y install libncurses5-dev libgnome2-dev libgnomeui-dev \
#    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev \
#    libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 \
#    liblua5.1-dev libperl-dev git libgpm-dev gpm

# 2. Remove old vim installs
#  $ sudo apt -y remove vim vim-runtime gvim && \
#    sudo apt -y autoremove && \
#    sudo apt -y autoclean

## Script Install ##############################################################

vim_dir="${HOME}/source/misc/vim"
if [ -d $vim_dir ]; then
    echo "git pull ${vim_dir} ..."
    cd $vim_dir
    git pull
else
    mkdir -p ${vim_dir} && cd ${vim_dir}
    echo "git clone --recursive ${vim_dir} ..."
    git clone --recursive https://github.com/vim/vim.git $vim_dir
    cd $vim_dir
fi

python2_config="/usr/lib/python2.7/config-x86_64-linux-gnu"
python3_config="/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
if [[ -d ${python2_config} && -d ${python3_config} ]]; then
    # check python directories, python must be installed to continue
    echo "configuring..."
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=${python2_config} \
        --enable-python3interp=yes \
        --with-python3-config-dir=${python3_config} \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
        --enable-gpm \
        --prefix=/usr/local

    echo "make..."
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
    echo "make install..."
    sudo make install
else
    if [ ! -d ${python2_config} ]; then
        echo "Error! Python2 config not found: ${python2_config}"
    fi
    if [ ! -d ${python3_config} ]; then
        echo "Error! Python3 config not found: ${python3_config}"
    fi
    exit 1
fi
