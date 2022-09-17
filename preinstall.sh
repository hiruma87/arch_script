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
sleep 1

sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf

#echo '[multilib]
#Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
sleep 1

#vim /etc/pacman.conf
sleep 1
echo "Done"
sleep 1

echo '##################################################################'
echo 'Update mirrorlist'
echo '##################################################################'
sleep 1
pacman -Sy
sleep 1
echo "Done"
sleep 1

echo '##################################################################'
echo 'Set Local time'
echo '##################################################################'
sleep 1

ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
sleep 1
echo "Done"
sleep 1

hwclock --systohc
sleep 1
echo "Done"
sleep 1

echo '##################################################################'
echo 'Setting Locale'
echo '##################################################################'
sleep 1

sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
sleep 1
echo "Done"
sleep 1

locale-gen
sleep 1
echo "Done"
sleep 1

echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
sleep 1
echo "Done"

echo '##################################################################'
echo 'Set Hosts'
echo '##################################################################'
sleep 1

hostnamectl set-hostname $host
sleep 1
hostnamectl
sleep 1
echo '127.0.0.1       localhost
::1             localhost
127.0.1.1       asura.localdomain       asura
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters' >> /etc/hosts

echo "Done"
sleep 1

echo '##################################################################'
echo "Installing Packages"
echo '##################################################################'
sleep 1
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
#linux-zen-headers
#linux-lts-headers
linux-headers
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
gvfs-mtp
)

for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $pkg;tput sgr0;
	echo "################################################################"
	
  sleep 1
func_install $pkg
done

echo "Done"
sleep 1

#sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

echo '##################################################################'
echo 'Compile kernel mkinitcpio'
echo '##################################################################'
sleep 1

mkinitcpio -p linux-zen
mkinitcpio -p linux-lts
sleep 1

echo '##################################################################'
echo 'Set root password'
echo '##################################################################'
sleep 1
echo -e "$rtpw\n$rtpw" | passwd root
sleep 1

echo '##################################################################'
echo 'Create user'
echo '##################################################################'
sleep 1

useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash $user
sleep 1

echo '##################################################################'
echo 'Set user password'
echo '##################################################################'
sleep 1

echo -e "$uspw\n$uspw" | passwd $user
sleep 1

echo '##################################################################'
echo 'Add user to wheel'
echo '##################################################################'
sleep 1

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

sleep 1

echo '##################################################################'
echo 'Create bootloader'
echo '##################################################################'
sleep 1

grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck
sleep 1

echo '##################################################################'
echo 'Enable OS_PROBER'
echo '##################################################################'
sleep 1

echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
sleep 1

echo '##################################################################'
echo 'Create boot config'
echo '##################################################################'
sleep 1

grub-mkconfig -o /boot/grub/grub.cfg
sleep 1

echo '##################################################################'
echo 'Enable Network'
echo '##################################################################'
sleep 1

systemctl enable NetworkManager
exit
