#!/bin/sh
set -e

## Prerequisites ###############################################################

# Install dependencies: # ${DOTFILES}/scripts/install-tool-dependencies.sh

## Script Install ##############################################################

neovim_dir="${HOME}/source/tools/neovim"
if [ -d "${neovim_dir}" ]; then
    echo "git pull ${neovim_dir}..."
    cd "${neovim_dir}"
    git pull --rebase
else
    mkdir -p "${neovim_dir}" && cd "${neovim_dir}"
    echo "git clone --recursive ${neovim_dir}..."
    git clone --recursive https://github.com/neovim/neovim "${neovim_dir}"
    cd "${neovim_dir}"
fi

make distclean
make deps
make CMAKE_BUILD_TYPE=RelWithDebInfo
make CMAKE_INSTALL_PREFIX="${HOME}"/.local/neovim install

