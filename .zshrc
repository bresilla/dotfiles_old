#!/bin/zsh
#--------------------------------------------------------------------------------------------------------------------
###SCRIPTS PATH
export FPATH=~/.zsh:$FPATH
#export PATH=~/.scripts:$PATH
###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###SECRETS
[ -f ~/secret ] && source ~/secret

###COLOR OUTPUTS
autoload -U colors && colors
alias grep="grep --color=auto"
###CASE INSENSITIVE
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


#--------------------------------------------------------------------------------------------------------------------
###HISTORY STAFF
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt sharehistory  
setopt incappendhistory
setopt inc_append_history
setopt hist_ignore_all_dups
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt interactive_comments
setopt correct
setopt no_beep
setopt prompt_subst



#--------------------------------------------------------------------------------------------------------------------
###FASD and ENHANCD
[ -f ~/.enhancd/./init.sh ] && source ~/.enhancd/./init.sh
eval "$(fasd --init posix-alias zsh-hook)"



#--------------------------------------------------------------------------------------------------------------------
###PERCON AUTOSUGESTION
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
	bindkey -M vicmd '^R' percol_select_history
fi



#--------------------------------------------------------------------------------------------------------------------
###FUZZYFINDER
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fzf_history() { 
	zle -I; eval $(history | fzf +s | sed 's/ *[0-9]* *//') ; }
	zle -N fzf_history
bindkey '^H' fzf_killps
bindkey -M vicmd '^H' fzf_killps

fzf_killps() { 
	zle -I; ps -ef | sed 1d | fzf -m | awk '{print $2}' | xargs kill -${1:-9} ; }
	zle -N fzf_killps
bindkey '^X' fzf_killps
bindkey -M vicmd '^X' fzf_killps

fzf_cd() { 
	zle -I; DIR=$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf) && cd "$DIR" ; }
	zle -N fzf_cd
bindkey '^E' fzf_cd
bindkey -M vicmd '^E' fzf_cd
	
fzf_locate() {
	zle -I; xdg-open "$(locate "*" | fzf -e)" ;}
	zle -N fzf_locate
bindkey '^L' fzf_locate
bindkey -M vicmd '^L' fzf_locate


fzf-file() {
	LBUFFER="${LBUFFER}$(__fsel)"
	local ret=$?
	zle redisplay; typeset -f zle-line-init >/dev/null && zle zle-line-init; return $ret}
	zle -N   fzf-file
bindkey '^P' fzf-file
bindkey -M vicmd '^P' fzf-file



#--------------------------------------------------------------------------------------------------------------------
###VI MODE
bindkey -v
KEYTIMEOUT=1
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

bindkey -a u undo
bindkey -a '^T' redo
bindkey '^?' backward-delete-char
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward


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
bindkey -M vicmd "\e\e" sudo-command-line



#--------------------------------------------------------------------------------------------------------------------
###BOUNDLES
[ -f ~/.antigen/antigen.zsh ] && source ~/.antigen/antigen.zsh
antigen bundle supercrabtree/k
antigen bundle psprint/zsh-navigation-tools
antigen bundle willghatch/zsh-snippets
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen apply


#--------------------------------------------------------------------------------------------------------------------
###MODULES & ALIASES
[ -f ~/.alias ] && source ~/.alias
source ~/.zsh/texas_init.zsh
source ~/.zsh/theme.sh
source ~/.zsh/extract.plugin.zsh
source ~/.zsh/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search.zsh
source ~/.zsh/zsh-miscellaneous.zsh

