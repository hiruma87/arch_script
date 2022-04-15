echo -e "\nStarting NTP Daemon...\n"
sleep 3

timedatectl set-ntp true
sleep 3

echo -e "\nDone.\n\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nMounting Partitions...\n"
sleep 3
# mount the ROOT partition on "/mnt"
mount /dev/sda2 /mnt
sleep 3
#mount home partition
mkdir -p /mnt/home
mount /dev/sda3 /mnt/home

# create necessary directories
mkdir -p /mnt/boot/EFI
sleep 3
# mount the EFI partition on "/mnt/boot"
mount /dev/sda1 /mnt/boot/EFI
sleep 3
lsblk
sleep 3
echo -e "\nDone.\n\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nModifying Pacman Configuration...\n"
sleep 3
# enable options "color", "ParallelDownloads", "multilib (32-bit) repository"
sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
sleep 3
echo -e "\nDone.\n\n"
sleep 3

echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nPerforming Pacstrap Operation...\n"
sleep 3
func_install() {
	if pacstrap /mnt -Qi $1 &> /dev/null; then
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
    	pacstrap /mnt $1
    fi
}
# edit and adjust the "pkgs" file for desired packages (don't worry about any extra white spaces or new lines or comments as they will be omitted using sed and tr)
echo
echo "########################################################"
echo "Installing Packages"
echo "########################################################"
echo

i=(
base
linux-lts
linux-firmware
vim
bash-completion
git
)

for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $pkg;tput sgr0;
	echo "################################################################"
sleep 3
func_install $pkg
done

echo
echo "Done"
echo

sleep 3
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nGenerating FSTab...\n"
echo
genfstab -U /mnt >> /mnt/etc/fstab
sleep 3
cat /mnt/etc/fstab
sleep 3
echo -e "\nDone.\n\nBase installation is now complete.\n\n"
sleep 3
arch-chroot /mnt
