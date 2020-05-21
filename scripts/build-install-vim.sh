#!/bin/sh
set -e

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

## Script Install ##############################################################

vim_dir="${HOME}/source/tools/vim"
if [ -d "${vim_dir}" ]; then
    echo "git pull ${vim_dir}..."
    cd "${vim_dir}"
    git pull --rebase
else
    mkdir -p "${vim_dir}" && cd "${vim_dir}"
    echo "git clone --recursive ${vim_dir}..."
    git clone --recursive https://github.com/vim/vim.git "${vim_dir}"
    cd "${vim_dir}"
fi

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
    --prefix="${HOME}"/.local/vim

make -j$(($(nproc)-1)) VIMRUNTIMEDIR="${HOME}"/.local/vim/share/vim/vim82
make install
