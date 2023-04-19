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
####################################
#org-sercer and desktop
####################################
xorg-server
lightdm
lightdm-slick-greeter
lightdm-gtk-greeter
lightdm-gtk-greeter-settings
xfce4
xfce4-goodies
####################################
#GP
####################################
#nvidia-lts
#nvidia-dkms
nvidia
####################################
#misc
####################################
qbittorrent
python-pip
udiskie
keepassxc
xarchiver
unzip
unrar
smplayer
#flatpak
neofetch
####################################
#network
####################################
network-manager-applet
networkmanager-openvpn
easy-rsa
###################################
#audio
###################################
pipewire
pipewire-pulse
lib32-pipewire
pavucontrol
##################################
#bluetooth
##################################
bluez
bluez-libs
bluez-utils
blueberry
#################################
#web browser
#################################
firefox
#################################
#fonts
#################################
ttf-bitstream-vera
ttf-dejavu
ttf-droid
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 5
	func_install $name
done

sudo systemctl enable lightdm.service
sudo systemctl enable bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
