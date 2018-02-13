sudo add-apt-repository -r ppa:ubuntu-toolchain-r/test
sudo add-apt-repository ppa:gnome3-team/gnome3-staging
sudo add-apt-repository ppa:gnome3-team/gnome3
sudo add-apt-repository ppa:ubuntu-mozilla-daily/ppa
sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:maarten-fonville/protobuf
sudo add-apt-repository ppa:obsproject/obs-studio
sudo add-apt-repository ppa:plushuang-tw/uget-devel
sudo add-apt-repository ppa:webupd8team/terminix
sudo add-apt-repository ppa:thomas-schiex/blender
sudo add-apt-repository multiverse

#spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

#enpass
echo "deb http://repo.sinew.in/testing testing beta" | sudo tee /etc/apt/sources.list.d/enpass-testing.list
wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
#echo "deb http://repo.sinew.in/ stable main" | sudo tee /etc/apt/sources.list.d/enpass.list
#wget -O - http://repo.sinew.in/keys/enpass-linux.key | sudo apt-key add -

#typora
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
sudo add-apt-repository 'deb http://typora.io linux/'

#docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"


sudo apt update
sudo apt upgrade
#sudo apt dist-upgrade
#enpsudo apt-get install gnome

