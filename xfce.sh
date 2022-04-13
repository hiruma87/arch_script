#!/bin/bash
#set -e
###############################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


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

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
xorg-server
lightdm
xfce4
xfce4-goodies
cups
gutenprint
qbittorrent
pulseaudio
pulseaudio-bluetooth
bluez
bluez-libs
bluez-utils
blueberry
nvidia-lts
xarchiver
network-manager-applet
unzip
smplayer
keepassxc
firefox
vivaldi
vivaldi-ffmpeg-codecs
python-pip
wine-staging
wine-gecko
wine-mono
xfwm4-themes
galculator
networkmanager-openvpn
easy-rsa
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

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 5
	func_install $name
done

###############################################################################


tput setaf 5;echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable lightdm.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
