#!/bin/bash

export PATH=/home/trim/.i3:$PATH
export PATH=/home/trim/.scripts:$PATH

###MODULES
source ~/.scripts/texas
source ~/.scripts/jump

###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###ALIASES
[ -f ~/.alias ] && source ~/.alias



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
