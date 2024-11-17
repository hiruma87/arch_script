echo -e "\nStarting NTP Daemon...\n"
sleep 1

#timedatectl set-ntp true
timedatectl
sleep 1

echo -e "\nDone.\n\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nModifying Pacman Configuration...\n"
sleep 1
# enable options "color", "ParallelDownloads", "multilib (32-bit) repository"
sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
sleep 1
pacman-key --init
sleep 1
pacman-key --populate
sleep 1
pacman -Sy
echo -e "\nDone.\n\n"
sleep 1

echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nPerforming Pacstrap Operation...\n"
#pacman -S archlinux-keyring --noconfirm
sleep 1
func_install() {
  # if pacstrap /mnt -Qi $1 &> /dev/null; then
	#tput setaf 2
  	#echo "###############################################################################"
  	#echo "################## The package "$1" is already installed"
      	#echo "###############################################################################"
      	#echo
	#tput sgr0
  # else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	pacstrap -K /mnt $1
    #fi
}
# edit and adjust the "pkgs" file for desired packages (don't worry about any extra white spaces or new lines or comments as they will be omitted using sed and tr)
echo
echo "########################################################"
echo "Installing Packages"
echo "########################################################"
echo

i=(
base
base-devel
linux
vim #change to you favorite editor e.g Nano, emacs, neovim
bash-completion
)

for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $pkg;tput sgr0;
	echo "################################################################"
sleep 1
func_install $pkg
done

echo
echo "Done"
echo

sleep 1
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nGenerating FSTab...\n"
echo
genfstab -U /mnt >> /mnt/etc/fstab
sleep 1
cat /mnt/etc/fstab
sleep 1
echo -e "\nDone.\n\nBase installation is now complete.\n\n"
sleep 1
curl https://raw.githubusercontent.com/hiruma87/arch_script/main/preinstall.sh -o /mnt/preinstall.sh
sleep 1
chmod +x /mnt/preinstall.sh
#cp -rf preinstall.sh /mnt
arch-chroot /mnt /bin/bash
