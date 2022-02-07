#!/bin/bash

vim /etc/pacman.conf
sleep 10

pacman -Syyu --noconfirm

ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
sleep 10

hwclock --systohc
sleep 10

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sleep 10

locale-gen
sleep 10

echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
sleep 10

hostnamectl set-hostname asura
sleep 10

echo '127.0.0.1       localhost
::1             localhost
127.0.1.1       asura.localdomain       asura
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters' >> /etc/hosts
sleep 10

echo
echo "Installing Packages"

pacman -S --noconfirm base-devel intel-ucode linux-headers grub efibootmgr os-prober mtools dosfstools networkmanager wireless_tools wpa_supplicant dialog ntfs-3g gvfs git

echo
echo "Done"
echo
sleep 10

#sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

mkinitcpio -p linux
sleep 10

passwd
sleep 10

useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash asura
sleep 10

passwd asura
sleep 10

sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sleep 10

grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck
sleep 10

echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
sleep 10

grub-mkconfig -o /boot/grub/grub.cfg
sleep 10

systemctl enable NetworkManager
sleep 10

exit
