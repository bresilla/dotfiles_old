#! /usr/bin/env bash

[[ -d $DOTS ]] && DOTS=$PWD
[[ -d $SETS ]] && DOTS=../Sets

ln -s $DOTS/.config/* ~/.config/
ln -s $DOTS/.func ~/func
ln -s $DOTS/.sbin ~/.sbin

ln -s $DOTS/.bashrc ~/.bashrc
ln -s $DOTS/.gitconfig ~/.gitconfig
ln -s $DOTS/.profile ~/.profile
ln -s $DOTS/.startup ~/.startup
ln -s $DOTS/.tmux.conf ~/.tmux.conf
ln -s $DOTS/.zshrc ~/.zshrc


ln -s $SETS/.config/* ~/.config/
ln -s $SETS/.local/share/* ~/.local/share/
ln -s $SETS/.bin ~/bin
ln -s $SETS/.fonts ~/.fonts
ln -s $SETS/.gnupg ~/.gnupg
ln -s $SETS/.mozilla ~/.mozilla
ln -s $SETS/.password-store ~/.password-store
ln -s $SETS/.ssh ~/.ssh
ln -s $SETS/.tomb ~/.tomb
ln -s $SETS/.vscode ~/.vscode
ln -s $SETS/.wallpaper ~/.wallpaper
