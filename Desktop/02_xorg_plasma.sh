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
plasma-meta
dolphin
dolphin-plugin
kwrite
kcalc
bluedevil
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 5
	func_install $name
done

###############################################################################


cd "${HOME}"
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm
sleep 3


