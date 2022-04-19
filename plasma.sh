#!/bin/bash

sudo pacman -Syyu --noconfirm


func_install() {
	if pacman -Qi $1 &> /dev/null; then
	tput setaf 2
  	echo "###############################################################################"
  	echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Fonts

list=(
xorg-server
sddm
nvidia-lts
plasma
packagekit-qt5
bluedevil
pulseaudio
pulseaudio-bluetooth
thunar
thunar-volman
thunar-archive-plugin
kwrite
kcalc
konsole
cups
gutenprint
wine-staging
wine-gecko
wine-mono
xfce4-panel
kvantum
firefox
vivaldi
vivaldi-ffmpeg-codecs
keepassxc
smplayer
python-pip
xarchiver
unzip
unrar
networkmanager-openvpn
easy-rsa
ark
udiskie
flatpak
awesome-terminal-fonts
adobe-source-sans-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-roboto
ttf-ubuntu-font-family
tamsyn-font
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################
tput setaf 5;
echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable sddm.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0

pacman -Syyu


