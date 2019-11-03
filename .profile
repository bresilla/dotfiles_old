#USER_BIN
[[ -d "$HOME/.bin" ]] && PATH="$HOME/.bin:$PATH"
[[ -d "$HOME/.sbin" ]] && PATH="$HOME/.sbin:$PATH"
[[ -d "$HOME/.hack" ]] && PATH="$HOME/.hack:$PATH"
[[ -d "$HOME/.local/bin" ]] && PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/sbin" ]] && PATH="$HOME/.local/sbin:$PATH"

#GO
[[ -d "$HOME/.go/bin" ]] && PATH="$HOME/.go/bin:$PATH"
#RUST
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"
#NIM
[[ -d "$HOME/.nimble/bin" ]] && PATH="$HOME/.nimble/bin:$PATH"
#CONDA
[[ -d "/opt/conda/bin" ]] && PATH="/opt/conda/bin:$PATH"

#NIX
[[ -d "$HOME/.nix-profile/bin" ]] && PATH="$HOME/.nix-profile/bin:$PATH"
[[ -d "/nix/var/nix/profiles/default/bin" ]] && PATH="/nix/var/nix/profiles/default/bin:$PATH"

export BROWSER=firefox
export EDITOR=nvim
export TERMINAL=kitty

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export WINEPREFIX=~/.wine
export TZ='Europe/Berlin'

export DOT=/home/bresilla/Dots
export SET=/home/bresilla/Sets
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
