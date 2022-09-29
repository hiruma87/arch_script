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
#pulseaudio
#pulseaudio-alsa
#pulseaudio-bluetooth
#lib32-libpulse
pipewire
pipewire-pulse
lib32-pipewire
pavucontrol
#alsa-firmware
#alsa-lib
#alsa-plugins
#alsa-utils
#lib32-alsa-plugins
#lib32-alsa-lib
#playerctl
#volumeicon
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 1
	func_install $name
done

sudo rm -rf /etc/pipewire
sleep 1
sudo cp -rf /usr/share/pipewire/ /etc/pipewire/
sleep 1
