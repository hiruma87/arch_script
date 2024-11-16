#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING AUR SOFTWARE"
echo

cd "${HOME}"
mkdir .git
cd .git
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
    	yay -S --noconfirm --needed $1
    fi
}

PKGS=(
    #basic cinnamon desktop
    'xorg-server'
    'egl-wayland'
    'xorg-xinit'
    'xorg-xwininfo'
    'lightdm'
    'lightdm-slick-greeter'
    'cinnamon'
    'gnome-terminal'
    #utilities
    'cups'
    'cups-pdf'
    'system-config-printer'
    'gutenprint' #canon driver
    'nemo-fileroller'
    'unzip'
    'unrar'
    'flatpak'
    'grub-btrfs'
    'btrfs-assistant'
    'python-pipx'
    'wireless_tools'
    'inotify-tools'
    'jq'
    #bluetooth
    'bluez'
    'bluez-utils'
    'blueberry'
    'bluez-libs'
    #audio
    'pipewire'
    'wireplumber'
    'pipewire-alsa'
    'pipewire-jack'
    'pipewire-pulse'
    'libpulse'
    'gst-plugin-pipewire'
    'pavucontrol'
    # applications
    'mintstick'
    'xed'
    'gnome-screenshot'
    'redshift'
    'onboard'
    'sticky'
    'xviewer'
    'xreader'
    'gnome-disk-utility'
    'gnome-calculator'
    'simple-scan'
    'pix'
    'transmission-gtk'
    'gnome-calendar'
    'libreoffice-fresh'
    'rhythmbox'
    'smplayer'
    'baobab'
    'gufw'
    'mintlocale'
    'cinnamon-translations'
    'gnome-keyring'
    'xdg-user-dirs-gtk'
    ##'network-manager-applet'
    # themes
    'mint-themes'
    'mint-y-icons'
    'mint-x-icons'
    # fonts
    'noto-fonts'
    'noto-fonts-cjk'
    'noto-fonts-emoji'
    'ttf-ubuntu-font-family'
    'ttf-roboto'
    'ttf-roboto-mono'
)

for PKG in "${PKGS[@]}"; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $PKG;tput sgr0;
	echo "################################################################"
	func_install $PKG
    sleep 1
done

sudo systemctl enable cups
sudo systemctl enable bluetooth
sudo systemctl enable lightdm.service
sudo systemctl enable reflector.service
sudo systemctl enable reflector.timer
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
sudo systemctl enable upower
echo
echo "Done!"
echo
