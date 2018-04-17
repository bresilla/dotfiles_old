#!/bin/zsh

###FUNCTION PATH
export FPATH=~/.zsh:$FPATH
export PATH=~/.i3:$PATH
export PATH=~/.i3/i3ass:$PATH
export PATH=~/.scripts:$PATH

###FUNCTIONS
for file in ~/.func/*; do
    source "$file"
done

###ALIASES
[ -f ~/.alias ] && source ~/.alias

###MODULES
source ~/.antigen/antigen.zsh
source ~/.zsh/texas_init.zsh
source ~/.zsh/autosuggestions.zsh
source ~/.zsh/theme.sh


###CUDA
export PATH=/usr/local/cuda-9.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/lib/nvidia-390:$LD_LIBReARY_PATH


###GAZEBO
export GAZEBO_MODEL_PATH=~/.gazebo/models

###ARDUPILOT SITL
export PATH=$PATH:$HOME/.ardupilot/Tools/autotest


##MAC adresses
export PI=b8:27:eb:32:88:26
export PI2=00:e0:4c:81:8b:06
export PROF=24:fd:52:1A:8f:78

