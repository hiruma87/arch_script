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
    	yay -S --noconfirm --needed $1
    fi
}

PKGS=(

    'jmtpfs'
    'mesa'
    'lib32-mesa'
    'vulkan-radeon'
    'lib32-vulkan-radeon'
    'keepassxc'
    'smplayer'
    'mtools'
    'wpa_supplicant'
    'gvfs'
    'gvfs-mtp'
    'dosfstools'
    'mtools'
    'vim'
    'git'
    'cmake'
    'python-pip'
    'wine-staging'
    'wine-mono'
    'wine-gecko'
    'xf86-video-amdgpu'
    'noto-fonts-emoji'
    'bash-completion'
    'whatsie'
    'moderndeck-bin'
    'microsoft-edge-stable-bin'
    'adobe-source-han-serif-jp-fonts'
    'adobe-source-han-serif-kr-fonts'
    'adobe-source-han-serif-cn-fonts'
    'adobe-source-han-serif-tw-fonts'
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
    sleep 3
#sudo systemctl enable cronie.service
#sudo systemctl enable --now zramd.service
echo
echo "Done!"
echo
