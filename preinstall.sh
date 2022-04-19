#!/bin/bash
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nEnter username to be created:\n"

read user

echo -e "\nEnter new password for $user:\n"

read uspw

echo -e "\nEnter new password for root:\n"

read rtpw

echo -e "\nEnter new hostname (device name):\n"

read host
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nUpdating Pacman Configuration (this time for installation destination system)...\n"



echo '##################################################################'
echo 'Change pacman.conf'
echo '##################################################################'
sleep 2

sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf

#echo '[multilib]
#Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
sleep 2

#vim /etc/pacman.conf
sleep 2
echo "Done"
sleep 2

echo '##################################################################'
echo 'Update mirrorlist'
echo '##################################################################'
sleep 2
pacman -Syyu --noconfirm
sleep 2
echo "Done"
sleep 2

echo '##################################################################'
echo 'Set Local time'
echo '##################################################################'
sleep 2

ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
sleep 2
echo "Done"
sleep 2

hwclock --systohc
sleep 2
echo "Done"
sleep 2

echo '##################################################################'
echo 'Setting Locale'
echo '##################################################################'
sleep 2

sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
sleep 2
echo "Done"
sleep 2

locale-gen
sleep 2
echo "Done"
sleep 2

echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
sleep 2
echo "Done"
sleep 2

echo '##################################################################'
echo 'Set Hosts'
echo '##################################################################'
sleep 2

hostnamectl set-hostname $host
sleep 2
hostnamectl
sleep 3
echo '127.0.0.1       localhost
::1             localhost
127.0.1.1       asura.localdomain       asura
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters' >> /etc/hosts

sleep 2
echo "Done"
sleep 2

echo '##################################################################'
echo "Installing Packages"
echo '##################################################################'
sleep 2
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
    	pacman -S --noconfirm --needed $1
    fi
}

i=(
base-devel
intel-ucode
linux-lts-headers
grub efibootmgr
os-prober
mtools
dosfstools
networkmanager
wireless_tools
wpa_supplicant
dialog
ntfs-3g
gvfs
)

for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $pkg;tput sgr0;
	echo "################################################################"
	
  sleep 3
func_install $pkg
done

echo "Done"
sleep 2

#sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

echo '##################################################################'
echo 'Compile kernel mkinitcpio'
echo '##################################################################'
sleep 2

mkinitcpio -p linux-lts
sleep 2

echo '##################################################################'
echo 'Set root password'
echo '##################################################################'
sleep 2
echo -e "$rtpw\n$rtpw" | passwd root
sleep 2

echo '##################################################################'
echo 'Create user'
echo '##################################################################'
sleep 2

useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash $user
sleep 2

echo '##################################################################'
echo 'Set user password'
echo '##################################################################'
sleep 2

echo -e "$uspw\n$uspw" | passwd $user
sleep 2

echo '##################################################################'
echo 'Add user to wheel'
echo '##################################################################'
sleep 2

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

sleep 2

echo '##################################################################'
echo 'Create bootloader'
echo '##################################################################'
sleep 2

grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck
sleep 2

echo '##################################################################'
echo 'Enable OS_PROBER'
echo '##################################################################'
sleep 2

echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
sleep 2

echo '##################################################################'
echo 'Create boot config'
echo '##################################################################'
sleep 2

grub-mkconfig -o /boot/grub/grub.cfg
sleep 2

echo '##################################################################'
echo 'Enable Network'
echo '##################################################################'
sleep 2

systemctl enable NetworkManager

sleep 2
echo '#######################################################'
echo 'Create a swapfile'
echo '#######################################################'
sleep 2
dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
sleep 2
chmod 600 /swapfile
sleep 2
mkswap /swapfile
sleep 2
cp /etc/fstab /etc/fstab.bak
sleep 2
echo '/swapfile none swap sw 0 0' >> /etc/fstab
sleep 2
cat /etc/fstab
sleep 2
swapon -a
sleep 2
free -m
sleep 2

exit
