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
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm
sleep 3


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

    # UTILITIES -----------------------------------------------------------

    #'timeshift'                 # Backup and Restore
    'snapper-support'
    'btrfs-assistant'
    'jmtpfs'
    #'zramd'
    'gksu'
    'hid-sony-panic-fix-dkms'
    #'android-file-transfer-linux-git'
    
    # COMMUNICATIONS ------------------------------------------------------

    'whatsie'
    'moderndeck-bin'
    #'appimaglauncher'

    # THEMES --------------------------------------------------------------


    # APPS ----------------------------------------------------------------

    #'yuzu-mainline-bin'
    'microsoft-edge-stable-bin'
    #'lutris-git'
    #'ryujinx-git'
    #'pamac-all'
    #'twitch-bin'
    #'facebook-nativefier'
    
    # FONTS----------------------------------------------------------------
    # Japanese
    'adobe-source-han-sans-jp-fonts'
    #'adobe-source-han-serif-jp-fonts'
    #'otf-ipafont'
    'ttf-hanazono'
    #'ttf-sazanami'
    #'ttf-koruri'
    #'ttf-monapo'
    #'ttf-mplus'
    #'ttf-vlgothic'
)

coubt = 0
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

