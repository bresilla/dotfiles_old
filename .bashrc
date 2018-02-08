#!/bin/bash

export PATH=/home/trim/.i3:$PATH
export PATH=/home/trim/.scripts:$PATH

source ~/.scripts/texas
source ~/.scripts/jump

source ~/.alias/shortcuts
source ~/.alias/system
source ~/.alias/ros
source ~/.alias/network
source ~/.alias/dronekit

# Path to the bash it configuration
export BASH_IT="/home/trim/.bash-it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='candy'

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Load Bash It
source "$BASH_IT"/bash_it.sh

export PATH=/usr/local/cuda-9.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:$LD_LIBRARY_PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
