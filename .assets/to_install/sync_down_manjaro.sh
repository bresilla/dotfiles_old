#SHELL STAFF
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.tmux /home/trim/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.fpath /home/trim/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.zsh /home/trim/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.antigen /home/trim/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/ranger /home/trim/.config/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.linuxbrew /home/trim/
rsync -az --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.zshrc /home/trim/
rsync -az --progress -s /run/media/trim/data/LINUX/SYNC/SHELL/.tmux.conf /home/trim/



#EXTENSIONS
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/extensions/.vscode /home/trim/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/extensions/extensions /home/trim/.local/share/gnome-shell/



#APP CONFIGS and other ASSETS
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/app_config/ /home/trim/.config/
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/assets/ /home/trim/.assets/



#COSTUMIZATION
rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/themes/wallpapers/ /home/trim/.wallpapers/
sudo rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/themes/themes /usr/share
sudo rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/themes/icons /usr/share
sudo rsync -r -t -v --progress -s /run/media/trim/data/LINUX/SYNC/themes/fonts /usr/share



#SOURCE LIST

