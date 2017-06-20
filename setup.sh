#!/bin/bash

 DOT_FILES=(.bashrc .bash_profile .Xresources .emacs.d .tmux .tmux.conf)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
