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

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export ORANGE='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CAYN='\033[0;36m'
export GRAY='\033[0;37m'
export YELLOW='\033[1;33m'
export NOCOLOR='\033[0m'

export BAT_THEME="TwoDark"
