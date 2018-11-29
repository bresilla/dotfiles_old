if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.sbin" ] ; then
    PATH="$HOME/.sbin:$PATH"
fi

if [ -d "$HOME/.hack" ] ; then
    PATH="$HOME/.hack:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/sbin" ] ; then
    PATH="$HOME/.local/sbin:$PATH"
fi

export EDITOR=nvim
export WINEPREFIX=~/.wine

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/

export DOT=/home/bresilla/Dots/
export SET=/home/bresilla/Sets/
export WALL=/usr/share/backgrounds
export PASS=/home/bresilla/Sets/pass

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

#export BAT_THEME="TwoDark"
