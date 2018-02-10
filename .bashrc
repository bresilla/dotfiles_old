#!/bin/bash

export PATH=/home/trim/.i3:$PATH
export PATH=/home/trim/.scripts:$PATH

source ~/.scripts/texas
source ~/.scripts/jump

source ~/.func/shortcuts
source ~/.func/system
source ~/.func/ros
source ~/.func/network
source ~/.func/dronekit

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
