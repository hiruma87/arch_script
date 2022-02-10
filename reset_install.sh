#!/bin/bash

echo '##################################################################'
echo "Installing Packages"
echo '##################################################################'
sleep 2

i=(
base-devel
intel-ucode
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
git
)
count = 0
for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	echo "Installing package nr.  "$count " " $pkg
	echo "################################################################"
	pacman -S --noconfirm $pkg
  sleep 3
done

echo "Done"
sleep 2

#sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

echo '##################################################################'
echo 'Compile kernel mkinitcpio'
echo '##################################################################'
sleep 2

mkinitcpio -p linux
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

exit
