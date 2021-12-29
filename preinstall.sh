#!/bin/bash

######################################################################################################################

pacman -S wget --noconfirm --needed

echo "Getting the ArcoLinux keys from the ArcoLinux repo"

wget https://github.com/arcolinux/arcolinux_repo/raw/master/x86_64/arcolinux-keyring-20230919-6-any.pkg.tar.zst -O /tmp/arcolinux-keyring-20230919-6-any.pkg.tar.zst
pacman -U --noconfirm --needed /tmp/arcolinux-keyring-20230919-6-any.pkg.tar.zst

######################################################################################################################

echo "Getting the latest arcolinux mirrors file"

wget https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist -O /etc/pacman.d/arcolinux-mirrorlist
echo '
#[arcolinux_repo_testing]
#SigLevel = Required DatabaseOptional
#Include = /etc/pacman.d/arcolinux-mirrorlist

[arcolinux_repo]
SigLevel = Required DatabaseOptional
Include = /etc/pacman.d/arcolinux-mirrorlist

[arcolinux_repo_3party]
SigLevel = Required DatabaseOptional
Include = /etc/pacman.d/arcolinux-mirrorlist

[arcolinux_repo_xlarge]
SigLevel = Required DatabaseOptional
Include = /etc/pacman.d/arcolinux-mirrorlist' | tee --append /etc/pacman.conf

vim /etc/pacman.conf
pacman -Syyu --noconfirm

ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
hwclock --systohc
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
hostnamectl set-hostname asura
echo '
127.0.0.1   localhost
::1         localhost
127.0.1.1   asura.localdomain   asura' >> /etc/hosts
pacman -S intel-ucode grub efibootmgr networkmanager wireless_tools wpa_supplicant os-prober mtools dosfstools base-devel linux-headers linux-zen-headers lvm2 --noconfirm
pacman -S nvidia-dkms ntfs-3g gvfs --noconfirm
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block lvm2 filesystems keyboard fsck)/' /etc/mkinitcpio.conf
mkinitcpio -p linux
mkinitcpio -p linux-zen
passwd
useradd -m -g users -G audio,video,network,games,wheel,storage,rfkill -s /bin/bash asura
passwd asura
EDITOR=vim visudo
grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
umount -a
exit
