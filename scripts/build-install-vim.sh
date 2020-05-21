#!/usr/bin/env bash
set -e

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

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

lua_prefix="/usr"
if [ ! -d ${lua_prefix} ]; then
    echo "Error! Lua prefix directory not found: ${lua_prefix}"
    # TODO Look for environment variables.
    exit 1
fi

# python2_config_dir="/usr/lib/python2.7/config-x86_64-linux-gnu"
# if [ ! -d ${python2_config_dir} ]; then
#     echo "Error! Python2.7 config not found: ${python2_config}"
#     exit 1
# fi

python3_7_config_dir="/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu"
python3_6_config_dir="/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu"
python3_5_config_dir="/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu"
if [ ! -d ${python3_7_config_dir} ]; then
    echo "Python3.7 config found: ${python3_7_config_dir}"
    python3_config_dir=${python3_7_config_dir}
elif [ ! -d ${python3_6_config_dir} ]; then
    echo "Python3.6 config found: ${python3_6_config_dir}"
    python3_config_dir=${python3_6_config_dir}
elif [ ! -d ${python3_config_dir} ]; then
    echo "Python3.5 config found: ${python3_5_config_dir}"
    python3_config_dir=${python3_5_config_dir}
else
    echo "Error: couldn't find python3, aborting."
    exit 1
fi

make distclean
./configure --with-features=huge \
    --enable-cscope \
    --enable-gpm \
    --enable-gui=gtk2 \
    --enable-largefile \
    --enable-multibyte \
    --enable-luainterp=yes \
    --enable-rubyinterp=yes \
    --enable-perlinterp=yes \
\ #    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --with-lua_prefix=${lua_prefix} \
\ #    --with-python-config-dir=${python2_config_dir} \
    --with-python3-config-dir=${python3_config_dir} \
    --enable-fail-if-missing \
    --prefix=${HOME}/.local/vim

make -j$(($(nproc)-1)) VIMRUNTIMEDIR=${HOME}/.local/vim/share/vim/vim82
make install
