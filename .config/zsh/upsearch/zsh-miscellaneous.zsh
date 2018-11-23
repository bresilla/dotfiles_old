#!/usr/bin/env zsh

################################################
#
# Register history-substring-search-up and history-substring-search-down as user-defined zle widgets
#
zle -N history-substring-search-up
zle -N history-substring-search-down

################################################
#
# Create the array "key" if it does not exist
#
[[ $(echo ${key+1}) != "1" ]] && typeset -A key && key=(Up "${terminfo[kcuu1]}" Down "${terminfo[kcud1]}" Home "${terminfo[khome]}" End "${terminfo[kend]}" Insert "${terminfo[kich1]}" Delete "${terminfo[kdch1]}" Left "${terminfo[kcub1]}" Right "${terminfo[kcuf1]}" PageUp "${terminfo[kpp]}" PageDown "${terminfo[knp]}")

################################################
#
# Define missing keys using terminfo
#
[[ "${key[Up]}"       == "" ]]  && key[Up]="${terminfo[kcuu1]}"
[[ "${key[Down]}"     == "" ]]  && key[Down]="${terminfo[kcud1]}"
[[ "${key[Home]}"     == "" ]]  && key[Home]="${terminfo[khome]}"
[[ "${key[End]}"      == "" ]]  && key[End]}="${terminfo[kend]}"
[[ "${key[Insert]}"   == "" ]]  && key[Insert]="${terminfo[kich1]}"
[[ "${key[Delete]}"   == "" ]]  && key[Delete]="${terminfo[kdch1]}"
[[ "${key[Left]}"     == "" ]]  && key[Left]}="${terminfo[kcub1]}"
[[ "${key[Right]}"    == "" ]]  && key[Right]="${terminfo[kcuf1]}"
[[ "${key[PageUp]}"   == "" ]]  && key[PageUp]="${terminfo[kpp]}"
[[ "${key[PageDown]}" == "" ]]  && key[PageDown]="${terminfo[knp]}"

################################################
#
# Bind the keys in $key
#
bindkey  "${key[Up]}"       history-substring-search-up
bindkey  "${key[Down]}"     history-substring-search-down
bindkey  "${key[Home]}"     beginning-of-line
bindkey  "${key[End]}"      end-of-line
bindkey  "${key[Insert]}"   overwrite-mode
bindkey  "${key[Delete]}"   delete-char
bindkey  "${key[Left]}"     backward-char
bindkey  "${key[Right]}"    forward-char
bindkey  "${key[PageUp]}"   beginning-of-history
bindkey  "${key[PageDown]}" end-of-history

################################################
#
# As a fallback bind some additional key codes that could be generated
#
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey "\e[A" history-substring-search-up
bindkey "\e[B" history-substring-search-down

bindkey "^[[A" history-substring-search-up
bindkey "^[0A" history-substring-search-up

bindkey "^[[B" history-substring-search-down
bindkey "^[0B" history-substring-search-down

################################################
#
# Bind history-incremental-search-backward, history-incremental-search-forward and backward-delete-char
# history-incremental-search-backward and history-incremental-search-forward
#
bindkey "^[[1;5C" forward-word
bindkey "^[01;5C" forward-word

bindkey "^[[1;5D" backward-word
bindkey "^[01;5D" backward-word

bindkey "^?" backward-delete-char

bindkey "^r" history-incremental-search-backward
bindkey "^s" history-incremental-search-forward
