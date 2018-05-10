#!/bin/zsh
#--------------------------------------------------------------------------------------------------------------------
###SCRIPTS PATH
export FPATH=~/.zsh:$FPATH
#export PATH=~/.scripts:$PATH
###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###MODULES & ALIASES
[ -f ~/.alias ] && source ~/.alias
source ~/.zsh/texas_init.zsh
source ~/.zsh/theme.sh
source ~/.zsh/extract.plugin.zsh




#--------------------------------------------------------------------------------------------------------------------
###HISTORY STAFF
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt 	  incappendhistory  #Immediately append to the history file, not just when a term is killed




#--------------------------------------------------------------------------------------------------------------------
###FUZZYFINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf_history() { 
	zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }; 
	zle -N fzf_history; 
bindkey '^H' fzf_history

fzf_killps() { 
	zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }; 
	zle -N fzf_killps; 
bindkey '^X' fzf_killps

fzf_cd() { 
	zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }; 
	zle -N fzf_cd; 
	bindkey '^E' fzf_cd
	
fzf_locate() {
	zle -I; xdg-open "$(locate "*" | fzf -e)" ;}
	zle -N fzf_locate
bindkey '^L' fzf_locate
	

[ -f ~/.enhancd/./init.sh ] && source ~/.enhancd/./init.sh




#--------------------------------------------------------------------------------------------------------------------
###FUZZYFINDER
[ -f ~/.antigen/antigen.zsh ] && source ~/.antigen/antigen.zsh
antigen bundle supercrabtree/k
antigen bundle psprint/zsh-navigation-tools
antigen bundle willghatch/zsh-snippets
antigen bundle gko/ssh-connect
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply



#--------------------------------------------------------------------------------------------------------------------
# Double press [Esc] [Esc] to add last command sudo
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line


#--------------------------------------------------------------------------------------------------------------------
