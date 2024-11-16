#!/usr/bin/env bash

tput setaf 3
echo "###############################################################################"
echo "##################  Installing package Plasma Desktop"
echo "###############################################################################"
echo
tput sgr0

cd "${HOME}"
mkdir git
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm


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
    	sudo yay -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
#org-sercer and desktop
xorg-server
xorg-xwayland
xorg-xinit
xorg-xwininfo
egl-wayland
sddm
plasma-desktop
plasma-workspace
ocean-sound-theme
oxygen
oxygen-sounds
plasma-nm
plasma-pa
bluedevil
breeze-gtk
drkonqi
kde-gtk-config
kde-plasma-addons
kgamma
kinfocenter
krdp
kscreen
kwrited
plasma-disks
plasma-systemmonitor
plasma-workspace-wallpapers
powerdevil
print-manager
sddm-kcm
xdg-desktop-portal-kde
breeze-grub
breeze-plymouth
flatpak-kcm
plymouth-kcm
#utilities
cups
cups-pdf
gutenprint
unzip
unrar
flatpak
grub-btrfs
btrfs-assistant
python-pipx
wireless_tools
inotify-tools
jq
wget
#and graphic
mesa
lib32-mesa
vulkan-radeon
lib32-vulkan-radeon
libva
lib32-libva
libva-utils
#bluetooth
bluez
bluez-utils
bluez-libs
#audip
pipewire
wireplumber
pipewire-alsa
pipewire-jack
pipewire-pulse
libpulse
gst-plugin-pipewire
#apps
konsole
kate
ark
discover
dolphin
firefox
opera
thunderbird
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 1
	func_install $name
done

##############################################################################

sudo systemctl enable cups
sudo systemctl enable bluetooth
sudo systemctl enable lightdm.service
sudo systemctl enable reflector.service
sudo systemctl enable reflector.timer
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
sudo systemctl enable upower

sleep 1
	echo "################################################################"
	tput setaf 3;echo "Installing complete" tput sgr0;
	echo "################################################################"
sleep 1
