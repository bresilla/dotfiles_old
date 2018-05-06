#!/bin/zsh

###FUNCTION PATH
export FPATH=~/.zsh:$FPATH
export PATH=~/.scripts:$PATH
export PATH=~/.i3/misc:$PATH
###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###ALIASES
[ -f ~/.alias ] && source ~/.alias




###MODULES
source ~/.antigen/antigen.zsh
source ~/.zsh/texas_init.zsh
source ~/.zsh/autosuggestions.zsh
source ~/.zsh/theme.sh


###CUDA
export PATH=/usr/local/cuda-9.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/lib/nvidia-390:$LD_LIBReARY_PATH


###GAZEBO
export GAZEBO_MODEL_PATH=~/.gazebo/models

###ARDUPILOT SITL
export PATH=$PATH:$HOME/.ardupilot/Tools/autotest


##MAC adresses
export PI=b8:27:eb:32:88:26
export PI2=00:e0:4c:81:8b:06
export PROF=24:fd:52:1A:8f:78

###FUZZYFINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf_history() { 
	zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; 
	zle -N fzf_history; 
	bindkey '^H' fzf_history

fzf_killps() { 
	zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; 
	zle -N fzf_killps; 
	bindkey '^Q' fzf_killps

fzf_cd() { 
	zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }; 
	zle -N fzf_cd; 
	bindkey '^E' fzf_cd
	
fzf_locate() {
	zle -I; xdg-open "$(locate "*" | fzf -e)" ;}
	zle -N fzf_locate
	bindkey '^L' fzf_locate
	

[ -f ~/.enhancd/./init.sh ] && source ~/.enhancd/./init.sh
	
