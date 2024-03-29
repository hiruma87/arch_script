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
#org-sercer and desktop
xorg-server
sddm
plasma
dolphin
dolphin-plugin
kwrite
kcalc
bluedevil
konsole
ark
gwenview
kbackup
kcalc
kclock
ktorrent
okular
cups
gutenprint
xsane
bluez
bluez-libs
bluez-utils
pipewire
pipewire-pulse
lib32-pipewire
udiskie
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
cd "${HOME}"
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm
sleep 1

sudo sh udiskie.sh
sh yay.sh

sudo systemctl enable bluetooth
sudo systemctl enable cups
sydo systemctl enable sddm


