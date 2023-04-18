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
#org-sercer and desktop
xorg-server
gnome
accerciser
dconf-editor
endeavor
gnome-connections
gnome-multi-writer
gnome-nettool
gnome-sound-recoder
gnome-terminal
gnome-tweaks
gnome-usage
lightsoff
#GP
nvidia
#misc apps
udiskie
python-pip
keepassxc
unzip
unrar
smplayer
neofetch
#audio
pipewire
pipewire-pulse
lib32-pipewire
#browser
firefox
#bluetooth
bluez
bluez-libs
bluez-utils
blueberry
#fonts
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

sudo systemctl enable gdm.service
sudo systemctl enable bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
