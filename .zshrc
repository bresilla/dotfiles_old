#!/usr/bin/env zsh
#--------------------------------------------------------------------------------------------------------------------
###WAL COLORS
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors.sh
#--------------------------------------------------------------------------------------------------------------------
###SCRIPTS PATH
export FPATH=~/.config/zsh:$FPATH
###FUNCTIONS
[ -d ~/.func ] && for file in ~/.func/*; do source "$file" ; done
###PROFILE
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
###DIRENV
eval "$(direnv hook zsh)"

###LAUNCHER
if [[ -n ${LAUNCHER} ]]; then
    PS1="> "
    bindkey -s "^M" " & \n"
    bind 'RETURN: "\e[4~ & \n exit \n"'
    return
fi

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
# do not prompt when rm *
setopt rmstarsilent

#--------------------------------------------------------------------------------------------------------------------
###HISTORY STAFF
export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
HISTFILE=~/.config/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt sharehistory
setopt incappendhistory
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt interactive_comments
setopt no_beep

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
bindkey -s '\es' sudo-command-line

#--------------------------------------------------------------------------------------------------------------------
###FUZZYFINDER
function run_history() { hister; zle reset-prompt; zle redisplay }
zle -N run_history
bindkey -M vicmd '^t' run_history
bindkey -M viins '^t' run_history
bindkey '^t' run_history

function run_killer() { killer; zle reset-prompt; zle redisplay }
zle -N run_killer
bindkey -M vicmd '^k' run_killer
bindkey -M viins '^k' run_killer
bindkey '^k' run_killer

function run_find() { finder; zle reset-prompt; zle redisplay }
zle -N run_find
bindkey -M vicmd '^f' run_find
bindkey -M viins '^f' run_find
bindkey '^f' run_find

function run_compile() { compile FastDebug && build; zle reset-prompt; zle redisplay }
zle -N run_compile
bindkey -M viins '^o' run_compile
bindkey -M vicmd '^o' run_compile
bindkey '^o' run_compile




#--------------------------------------------------------------------------------------------------------------------
###MODULES
autoload -U colors && colors
autoload compinit && compinit

# TMOUT=1
TRAPALRM() {
    if [ "$WIDGET" != "complete-word" ]; then
        zle reset-prompt
    fi
}

[ -d ~/.config/zsh/insult ] && . ~/.config/zsh/insult
[ -f ~/.config/zsh/theme ] && source ~/.config/zsh/theme
(( $+commands[thefuck] )) && eval $(thefuck --alias)
[ -f ~/.config/zsh/async ] && autoload -U async
[ -d ~/.config/zsh/cmdtime ] && source ~/.config/zsh/cmdtime/zsh-command-time.zsh
[ -d ~/.config/zsh/visualvi ] && source ~/.config/zsh/visualvi/zsh-vimode-visual.zsh
[ -d ~/.config/zsh/autosuggestions ] && source ~/.config/zsh/autosuggestions/zsh-autosuggestions.zsh
[ -d ~/.config/zsh/syntax ] && source ~/.config/zsh/syntax/zsh-syntax-highlighting.zsh
#[ -d ~/.config/zsh/almostontop ] && source ~/.config/zsh/almostontop/almostontop.plugin.zsh
[ -d ~/.config/zsh/upsearch ] && source ~/.config/zsh/upsearch/zsh-history-substring-search.zsh
[ -d ~/.config/zsh/upsearch ] && source ~/.config/zsh/upsearch/zsh-miscellaneous.zsh
[ -d ~/.config/zsh/autopair ] && source ~/.config//zsh/autopair/autopair.zh
[ -d ~/.config/zsh/completions ] && source ~/.config/zsh/completions/zsh-completions.zsh
[ -d ~/.config/zsh/goto ] && source ~/.config/zsh/goto/goto.sh
[ -d ~/.config/gitstatus ] && source ~/.config/gitstatus/gitstatus.prompt.zsh
