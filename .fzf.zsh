# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bresilla/.fzf/bin* ]]; then
  export PATH="$PATH:/home/bresilla/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bresilla/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/bresilla/.fzf/shell/key-bindings.zsh"

