
Skip to content
Pull requests
Issues
Marketplace
Explore
@hiruma87
johnynfulleffect /
ArchMatic
Public
forked from ChrisTitusTech/ArchMatic

Code
Pull requests
Actions
Projects
Wiki
Security

    Insights

ArchMatic/3-software-aur.sh
@johnynfulleffect
johnynfulleffect More utils (#12)
Latest commit 9df2ce6 on Aug 28, 2020
History
1 contributor
executable file 61 lines (42 sloc) 1.55 KB
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

echo "Please enter username:"
read username

cd "${HOME}"

echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"


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

cd ${HOME}/yay
makepkg -si


for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

echo
echo "Done!"
echo

