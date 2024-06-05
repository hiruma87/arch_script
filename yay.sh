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
    'cinnamon'
    'system-config-printer'
    'gnome-keyring'
    'gnome-terminal'
    'blueberry'
    'metacity'
    'lightdm'
    'pipewire'
    'pipewire-alsa'
    'pipewire-jack'
    'pipewire-pulse'
    'gst-plugin-pipewire'
    'libpulse'
    'wireplumber'
    'inotify-tools'
    'bash-completion'
    'opera'
    'opera-ffmpeg-codecs '
    'smplayer'
    'cups'
    'cups-pdf'
    'gutenprint'
    'print-manager'
    'keepassxc'
    'ttf-ubuntu-font-family'
    'otf-ipafont'
    'noto-fonts'
    'noto-fonts-emoji'
    'ttf-mplus-git'
    'flatpak'
    'git'
    'mint-themes'
    'mint-y-icons'
    'mint-x-icons'
    'cinnamon-control-center'
    'cinnamon-settings-daemon'
    'cinnamon-translation'
    'mint-locale'
    'file-roller'
    'mintstick'
    'xed'
    'gnome-screenshot'
    'onboard'
    'xviewer'
    'gnome-font-viewer'
    'xreader'
    'gnome-disk-utility'
    'gucharmap'
    'gnome-calculator'
    'simple-scan'
    'drawing'
    'webapp-manager'
    'thunderbird'
    'transmission-gtk'
    'gnome-calendar'
    'libreoffice-fresh'
    'python'
    'python-pipx'
    'rhythmbox'
    'baobab'
    'gnome-logs'
    'gufw'
    'plank'
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
sudo systemctl enable lightdm.service
sudo systemctl enable reflector.service
sudo systemctl enable reflector.timer
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
echo
echo "Done!"
echo
