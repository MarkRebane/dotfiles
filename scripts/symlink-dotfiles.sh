#!/bin/sh

date=$(date --rfc-3339='seconds')
source_dir="$(cd "$(dirname "$0")/.." && pwd)"

if [ -f ~/.bashrc ] && [ ! -h ~/.bashrc ] ; then
  mv "$HOME/.bashrc" "$HOME/dot-bashrc-$date"
fi
if [ ! -h ~/.bashrc ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.bashrc" "$HOME/.bashrc"
fi

if [ -f ~/.bash_logout ] && [ ! -h ~/.bash_logout ] ; then
  mv "$HOME/.bash_logout" "$HOME/dot-bash_logout-$date"
fi
if [ ! -h ~/.bash_logout ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.bash_logout" "$HOME/.bash_logout"
fi

if [ -f ~/.inputrc ] && [ ! -h ~/.inputrc ] ; then
  mv "$HOME/.inputrc" "$HOME/dot-inputrc-$date"
fi
if [ ! -h ~/.inputrc ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.inputrc" "$HOME/.inputrc"
fi

if [ -f ~/.profile ] && [ ! -h ~/.profile ] ; then
  mv "$HOME/.profile" "$HOME/dot-profile-$date"
fi
if [ ! -h ~/.profile ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.profile" "$HOME/.profile"
fi

if [ -f ~/.tmux.conf ] && [ ! -h ~/.tmux.conf ] ; then
  mv "$HOME/.tmux.conf" "$HOME/dot-tmux.conf-$date"
fi
if [ ! -h ~/.tmux.conf ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.tmux.conf" "$HOME/.tmux.conf"
fi

if [ -f ~/.vimrc ] && [ ! -h ~/.vimrc ] ; then
  mv "$HOME/.vimrc" "$HOME/dot-vimrc-$date"
fi
if [ ! -h ~/.vimrc ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.vimrc" "$HOME/.vimrc"
fi

if [ -d ~/.vim ] && [ ! -h ~/.vim ] ; then
  mv "$HOME/.vim" "$HOME/dot-vim-$date"
fi
if [ ! -h ~/.vim ] || [ "$1" = "--force" ] ; then
  ln -snf "$source_dir/.vim" "$HOME/.vim"
fi
