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
    'xorg-server'
    'xorg-xwayland'
    'bash-completion'
    'firefox'
    'microsoft-edge-stable-bin'
    'smplayer'
    'cups'
    'cups-pdf'
    'gutenprint'
    'foomatic-db-gutenprint-ppds'
    'keepassxc'
    'ttf-ubuntu-font-family'
    'otf-ipafont'
    'noto-fonts'
    'noto-fonts-emoji'
    'ttf-mplus-git'
    'flatpak'
    'git'
    'pipewire'
    'pipewire-alsa'
    'pipewire-jack'
    'pipewire-pulse'
    'gst-plugin-pipewire'
    'libpulse'
    'wireplumber'
    'plasma'
    'bluez'
    'bluez-utils'
    'printer-manager'
    'system-config-printer'
    'inotify-tools'
    'btrfs-assistant'
    'snapper-support'
    'grub-btrfs'

)

for PKG in "${PKGS[@]}"; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $PKG;tput sgr0;
	echo "################################################################"
	func_install $PKG
    sleep 3
done

cd "${HOME}"
mkdir .git
cd .git
echo "CLONING: Synth-shell"
git clone --recursive https://github.com/andresgongora/synth-shell.git
cd synth-shell
./setup.sh
sleep 3

sudo systemctl enable cups
sudo systemctl enable bluetooth
sudo systemctl enable sddm
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
echo
echo "Done!"
echo
