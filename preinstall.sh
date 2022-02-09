#!/bin/bash
echo '##################################################################'
echo 'Change pacman.conf'
echo '##################################################################'
sleep 2

vim /etc/pacman.conf
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

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
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

hostnamectl set-hostname asura
sleep 2

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
echo 'Set root password'
echo '##################################################################'
sleep 2
passwd
sleep 2

echo '##################################################################'
echo 'Create user'
echo '##################################################################'
sleep 2

useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash asura
sleep 2

echo '##################################################################'
echo 'Set user password'
echo '##################################################################'
sleep 2

passwd asura
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

exit
