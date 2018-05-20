#!/bin/bash

export PATH=~/.scripts:$PATH

###MODULES
source ~/.scripts/texas
source ~/.scripts/jump
source ~/.zsh/theme.sh

###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###ALIASES
[ -f ~/.alias ] && source ~/.alias

###SECRETS
[ -f ~/secret ] && source ~/secret

###FUZZYFINDER
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fh() {
	eval $(history | fzf +s | sed 's/ *[0-9]* *//')
}
