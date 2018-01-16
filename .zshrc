###FUNCTION PATH
export FPATH=~/.fpath:$FPATH
export PATH="~/.scripts:$PATH"


###ALIAS
source ~/.alias/shortcuts
source ~/.alias/system
source ~/.alias/ros
source ~/.alias/network
source ~/.alias/dronekit


###ANTIGEN AND ZSH MODULES
source ~/.antigen/antigen.zsh
source ~/.fpath/texas_init.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

filecon() {
    ~/.fpath/texas2
}
export filecon


###CUDA
export PATH=/usr/local/cuda/bin:${PATH}
export MANPATH=/usr/local/cuda/man:${MANPATH}
if [[ "${LD_LIBRARY_PATH}" != "" ]]
  then
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
  else
export LD_LIBRARY_PATH=/usr/local/cuda/lib64
  fi



###GAZEBO
export GAZEBO_MODEL_PATH=~/.gazebo/models


###ARDUPILOT SITL
export PATH=$PATH:$HOME/.ardupilot/Tools/autotest


##MAC adresses
export PI=b8:27:eb:32:88:26
export PI2=00:e0:4c:81:8b:06
export PROF=24:fd:52:1A:8f:78
