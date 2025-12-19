#!/bin/sh

DATE=$(date --rfc-3339='seconds')
DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

if [ -f ~/.bashrc ] && [ ! -h ~/.bashrc ] ; then
    mv "$HOME/.bashrc" "$HOME/dot-bashrc-$DATE"
fi
if [ ! -h ~/.bashrc ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-bashrc" "$HOME/.bashrc"
fi

if [ -f ~/.bash_logout ] && [ ! -h ~/.bash_logout ] ; then
    mv "$HOME/.bash_logout" "$HOME/dot-bash_logout-$DATE"
fi
if [ ! -h ~/.bash_logout ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-bash_logout" "$HOME/.bash_logout"
fi

if [ -f ~/.inputrc ] && [ ! -h ~/.inputrc ] ; then
    mv "$HOME/.inputrc" "$HOME/dot-inputrc-$DATE"
fi
if [ ! -h ~/.inputrc ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-inputrc" "$HOME/.inputrc"
fi

if [ -f ~/.profile ] && [ ! -h ~/.profile ] ; then
    mv "$HOME/.profile" "$HOME/dot-profile-$DATE"
fi
if [ ! -h ~/.profile ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-profile" "$HOME/.profile"
fi

if [ -f ~/.tmux.conf ] && [ ! -h ~/.tmux.conf ] ; then
    mv "$HOME/.tmux.conf" "$HOME/dot-tmux.conf-$DATE"
fi
if [ ! -h ~/.tmux.conf ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-tmux.conf" "$HOME/.tmux.conf"
fi

if [ -f ~/.vimrc ] && [ ! -h ~/.vimrc ] ; then
    mv "$HOME/.vimrc" "$HOME/dot-vimrc-$DATE"
fi
if [ ! -h ~/.vimrc ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-vimrc" "$HOME/.vimrc"
fi

if [ -d ~/.vim ] && [ ! -h ~/.vim ] ; then
    mv "$HOME/.vim" "$HOME/dot-vim-$DATE"
fi
if [ ! -h ~/.vim ] || [ "$1" = "--force" ] ; then
    ln -snf "$DOTFILES_DIR/dot-vim" "$HOME/.vim"
fi
