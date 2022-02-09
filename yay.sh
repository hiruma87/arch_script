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
makepkg -si
sleep 3

PKGS=(

    # UTILITIES -----------------------------------------------------------

    'timeshift'                 # Backup and Restore
    #'rtl8812au-dkms-git'
    
    # COMMUNICATIONS ------------------------------------------------------

    'whatsapp-nativefier'
    'twitter-nativefier'

    # THEMES --------------------------------------------------------------


    # APPS ----------------------------------------------------------------

    'yuzu-mainline-bin'
    'lutris-git'
    'pamac-all'
    
    # FONTS----------------------------------------------------------------
    # Japanese
    'adobe-source-han-sans-jp-fonts'
    'adobe-source-han-serif-jp-fonts'
    'otf-ipafont'
    'ttf-hanazono'
    'ttf-sazanami'
    'ttf-koruri'
    'ttf-monapo'
    'ttf-mplus'
    'ttf-vlgothic'
)

coubt = 0
for PKG in "${PKGS[@]}"; do
	count=$[count+1]
	echo "################################################################"
	echo "Installing package nr.  "$count " " $PKG
	echo "################################################################"
    yay -S --noconfirm $PKG
    sleep 3
done

sudo pacman -S steam
    sleep 3
echo
echo "Done!"
echo

