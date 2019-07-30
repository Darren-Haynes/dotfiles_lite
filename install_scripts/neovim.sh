#!/bin/bash

# Install and configure vim

sudo apt-get update
sudo apt install vim

undo_dir="$HOME/.vim/undodir"
if [ ! -d "$undo_dir" ]; then
  mkdir -p "$HOME/.vim/undodir"
  echo "$HOME/.vim/undodir directory created."
  else
    echo "Skip making $HOME/.vim/undodir, directory already exists."
fi

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
