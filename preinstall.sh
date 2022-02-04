#!/bin/bash

vim /etc/pacman.conf

pacman -Syyu --noconfirm

ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime

hwclock --systohc

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen

locale-gen

echo 'LANG=en_US.UTF-8' >> /etc/locale.conf

hostnamectl set-hostname asura

echo '127.0.0.1       localhost
::1             localhost
127.0.1.1       asura.localdomain       asura
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters' >> /etc/hosts

echo
echo "Installing Packages"

PKGS=(
base-devel
intel-ucode
linux-headers
linux-zen-headers
grub
efibootmgr
os-prober
mtools
dosfstools
networkmanager
wireless_tools
wpa_supplicant
dialog
ntfs-3g
gvfs
reflector
git
)
count=0
for PKG in "${PKGS[@]}" ; do
	count=$[count+1]
        echo "########################################################"
	echo echo "Installing package nr.  "$count" "${PKG}
        echo "########################################################"
	pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done"
echo

reflector

sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf

mkinitcpio -p linux

mkinitcpio -p linux-zen

passwd

useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash asura

passwd asura

sed -i 's/^# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers

grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck

echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

exit
