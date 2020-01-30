#! /usr/bin/env bash

[[ -d $DOTS ]] && echo "No \$DOTS directory found!" && exit 1

FILES=$DOTS/.config/*
for f in $FILES; do
    ln -sf $f ~/.config/
    echo $f
done

FILES=$DOTS/.local/share/*
for f in $FILES; do
    ln -sf $f ~/.local/share/
    echo $f
done

ln -sf $DOTS/.func ~/.func
ln -sf $DOTS/.sbin ~/.sbin
ln -sf $DOTS/.bashrc ~/.bashrc
ln -sf $DOTS/.gitconfig ~/.gitconfig
ln -sf $DOTS/.profile ~/.profile
ln -sf $DOTS/.startup ~/.startup
ln -sf $DOTS/.tmux.conf ~/.tmux.conf
ln -sf $DOTS/.zshrc ~/.zshrc


ln -sf $DOTS/.other/.bin ~/.bin
ln -sf $DOTS/.other/.fonts ~/.fonts
ln -sf $DOTS/.other/.gnupg ~/.gnupg
ln -sf $DOTS/.other/.mozilla ~/.mozilla
ln -sf $DOTS/.other/.password-store ~/.password-store
ln -sf $DOTS/.other/.ssh ~/.ssh
ln -sf $DOTS/.other/.tomb ~/.tomb
ln -sf $DOTS/.other/.vscode ~/.vscode
ln -sf $DOTS/.other/.wallpaper ~/.wallpaper
