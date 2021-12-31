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


PKGS=(

    # UTILITIES -----------------------------------------------------------

    'timeshift'                 # Backup and Restore

    # COMMUNICATIONS ------------------------------------------------------

    'whatsapp-nativefier'
    'twitter-nativefier'

    # THEMES --------------------------------------------------------------


    # APPS ----------------------------------------------------------------

    'yuzu-mainline-bin'
    'lutris-git'
    'protonup-qt'
)


for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

sudo pacman -S steam

echo
echo "Done!"
echo

