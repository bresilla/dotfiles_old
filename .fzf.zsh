# Setup fzf
# ---------
if [[ ! "$PATH" == */home/trim/.fzf/bin* ]]; then
  export PATH="$PATH:/home/trim/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/trim/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/trim/.fzf/shell/key-bindings.zsh"

