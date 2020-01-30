#USER_BIN
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"
[[ -d "$HOME/.sbin" ]] && PATH="$HOME/.sbin:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/sbin" ]] && PATH="$HOME/.local/sbin:$PATH"

#GO
[[ -d "/opt/bin/go/bin" ]] && PATH="/opt/bin/go/bin:$PATH"
#RUST
[[ -d "/opt/bin/cargo/bin" ]] && PATH="/opt/bin/cargo/bin:$PATH"
#NIM
[[ -d "/opt/bin/nimble/bin" ]] && PATH="/opt/bin/nimble/bin:$PATH"

#NIX
[[ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]] && . $HOME/.nix-profile/etc/profile.d/nix.sh;
# [[ -d "$HOME/.nix-profile/bin" ]] && PATH="$HOME/.nix-profile/bin:$PATH";
# [[ -d "/nix/var/nix/profiles/default/bin" ]] && PATH="/nix/var/nix/profiles/default/bin:$PATH";

#OTHER VARS
[[ -e "/home/bresilla/.variables" ]] && source /home/bresilla/.variables

export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=kitty
export MANPATH=$(manpath)


export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
export MONITOR1=eDP1
export MONITOR2=DP1

export CARGO_HOME="/opt/bin/cargo"
export NIMBLE_DIR="/opt/bin/nimble"
export GOPATH="/opt/bin/go"
export GOBIN="$GOPATH/bin"


export UBUNTUPATH="/opt/chroot/ubuntu"
export TZ='Europe/Berlin'


export WINEPREFIX=/opt/wine
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export XDG_CONFIG_HOME=/home/$USER/.config
export XDG_CONFIG_PATH=/home/$USER/.config

export IPFS_PATH=/home/bresilla/sync/planetary/ipfs

export DOTS=/home/bresilla/dots
export WALL=/usr/share/backgrounds
export CODE=/home/bresilla/DATA/CODE
export PRO=/home/bresilla/DATA/CODE/PROJECTS

export FOREGROUND=$(xrdb -query | grep 'foreground:'| awk 'NR==1{print $NF}')
export BACKGROUND=$(xrdb -query | grep 'background:'| awk 'NR==1{print $NF}')
export BLACK=$(xrdb -query | grep 'color0:'| awk 'NR==1{print $NF}')
export RED=$(xrdb -query | grep 'color1:'| awk 'NR==1{print $NF}')
export GREEN=$(xrdb -query | grep 'color2:'| awk 'NR==1{print $NF}')
export YELLOW=$(xrdb -query | grep 'color3:'| awk 'NR==1{print $NF}')
export BLUE=$(xrdb -query | grep 'color4:'| awk 'NR==1{print $NF}')
export MAGENTA=$(xrdb -query | grep 'color5:'| awk 'NR==1{print $NF}')
export CYAN=$(xrdb -query | grep 'color6:'| awk 'NR==1{print $NF}')
export WHITE=$(xrdb -query | grep 'color7:'| awk 'NR==1{print $NF}')
