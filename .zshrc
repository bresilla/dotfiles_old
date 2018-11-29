#!/usr/bin/env zsh

#--------------------------------------------------------------------------------------------------------------------
###SCRIPTS PATH
export FPATH=~/.config/zsh:$FPATH
###FUNCTIONS
[ -d ~/.func ] && for file in ~/.func/*; do
    source "$file"
done
###PROFILE
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

###CASE INSENSITIVE

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# treat `#', `~' and `^' characters as part of patterns for filename generation
setopt extended_glob
setopt local_options
# case insensitive matching when performing filename expansion
setopt no_case_glob
# if command not found, but directory found, cd into this directory
setopt auto_cd
# turn off automatic matching of ~/ directories (speeds things up)
setopt no_cdable_vars
# prevents you from accidentally overwriting an existing file
setopt noclobber
# perform implicit tees or cats when multiple redirections are attempted
setopt multios
# do not send the HUP signal to backround jobs on shell exit
setopt no_hup
# parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt prompt_subst

#--------------------------------------------------------------------------------------------------------------------
###HISTORY STAFF
HISTFILE=~/.config/zsh_history
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
setopt no_beep

#--------------------------------------------------------------------------------------------------------------------
###FUZZYFINDER
fzf_history() {
	zle -I; eval $(history | tzf +s | sed 's/ *[0-9]* *//') ; }
	zle -N fzf_history
#bindkey '^H' fzf_history
bindkey -M vicmd '^H' fzf_history
bindkey -M viins '^H' fzf_history

fzf_killps() {
	zle -I; ps -ef | sed 1d | tux -m | awk '{print $2}' | xargs suda kill -${1:-9} ; }
	zle -N fzf_killps
#bindkey '^X' fzf_killps
bindkey -M vicmd '^X' fzf_killps

fzf-find() {
	zle -I; nvim "$(find $PWD -name "*" | tzf -e)"}
	zle -N   fzf-find
#bindkey '^F' fzf-file
bindkey -M vicmd '^F' fzf-find
bindkey -M viins '^F' fzf-find

#--------------------------------------------------------------------------------------------------------------------
###VI MODE

bindkey -v
DEFAULT_VI_MODE=viins
KEYTIMEOUT=1
set_vi_mode_cursor() {
    case $KEYMAP in
        vicmd)
          printf "\033[2 q"
          ;;
        main|viins)
          printf "\033[3 q"
          ;;
    esac
}

zle-keymap-select() {
    set_vi_mode_cursor
    zle reset-prompt
}

zle-line-init() {
    zle -K $DEFAULT_VI_MODE
}

zle -N zle-line-init
zle -N zle-keymap-select

vi-append-x-selection () { RBUFFER=$(xsel -o -p </dev/null)$RBUFFER; }
zle -N vi-append-x-selection
bindkey -M vicmd '^P' vi-append-x-selection

vi-yank-x-selection () { print -rn -- $CUTBUFFER | xsel -i -p; }
zle -N vi-yank-x-selection
bindkey -M vicmd '^Y' vi-yank-x-selection

#--------------------------------------------------------------------------------------------------------------------
# use SUDO for last command
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
bindkey -M vicmd '^S' sudo-command-line
bindkey -M viins '^S' sudo-command-line


#--------------------------------------------------------------------------------------------------------------------
###MODULES
autoload -U colors && colors
autoload compinit && compinit

[ -f ~/.config/zsh/alger ] && autoload -U alger
bindkey -s '\ez' "alger\n"

[ -f ~/.config/zsh/texas ] && autoload -U texas
bindkey -s '\et' "texas\n"

[ -f ~/.config/zsh/deer ] && autoload -U deer
zle -N deer
bindkey '\eu' deer


[ -f ~/.config/zsh/theme ] && source ~/.config/zsh/theme
#TMOUT=1
TRAPALRM() zle reset-prompt
(cat ~/.cache/wal/sequences &)
(( $+commands[thefuck] )) && eval $(thefuck --alias)
[ -f ~/.config/zsh/async ] && autoload -U async
[ -d ~/.config/zsh/cmdtime ] && source ~/.config/zsh/cmdtime/zsh-command-time.zsh
[ -d ~/.config/zsh/completions ] && source ~/.config/zsh/completions/zsh-completions.zsh
[ -d ~/.config/zsh/autosuggestions ] && source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh
[ -d ~/.config/zsh/syntax ] && source ~/.config/zsh/syntax/zsh-syntax-highlighting.zsh
#[ -d ~/.config/zsh/almostontop ] && source ~/.config/zsh/almostontop/almostontop.plugin.zsh
[ -d ~/.config/zsh/upsearch ] && source ~/.config/zsh/upsearch/zsh-history-substring-search.zsh
[ -d ~/.config/zsh/upsearch ] && source ~/.config/zsh/upsearch/zsh-miscellaneous.zsh
