#! /usr/bin/env bash

[[ -d $DOTS ]] && DOTS=$PWD
[[ -d $SETS ]] && DOTS=../Sets

ln -s $DOTS/.config/* ~/.config/
ln -s $SETS/.local/share/* ~/.local/share/

ln -s $DOTS/.func ~/func
ln -s $DOTS/.sbin ~/.sbin

ln -s $DOTS/.bashrc ~/.bashrc
ln -s $DOTS/.gitconfig ~/.gitconfig
ln -s $DOTS/.profile ~/.profile
ln -s $DOTS/.startup ~/.startup
ln -s $DOTS/.tmux.conf ~/.tmux.conf
ln -s $DOTS/.zshrc ~/.zshrc


ln -s $DOTS/.other/.bin ~/bin
ln -s $DOTS/.other/.fonts ~/.fonts
ln -s $DOTS/.other/.gnupg ~/.gnupg
ln -s $DOTS/.other/.mozilla ~/.mozilla
ln -s $DOTS/.other/.password-store ~/.password-store
ln -s $DOTS/.other/.ssh ~/.ssh
ln -s $DOTS/.other/.tomb ~/.tomb
ln -s $DOTS/.other/.vscode ~/.vscode
ln -s $DOTS/.other/.wallpaper ~/.wallpaper
