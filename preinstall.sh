#!/bin/bash
echo "-------------------------------------------------------------------------------------------------------------------"
echo -e "\nEnter username to be created:\n"

read user

echo -e "\nEnter new password for $user:\n"

read uspw

echo -e "\nEnter new password for root:\n"

read rtpw

echo -e "\nEnter new hostname (device name):\n"

read host

echo -e "\nEnter timezone:\n" #mine Asia/Kuala_Lumpur, you can check your timeone via timedatectl list-timezones"

read tzone

echo "-------------------------------------------------------------------------------------------------------------------"
echo -e "\nUpdating Pacman Configuration (this time for installation destination system)...\n"

echo '##################################################################'
echo 'Change pacman.conf'
echo '##################################################################'
sleep 1
echo "'sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf'"
sleep 1
sed -i 's #Color Color ; s #ParallelDownloads ParallelDownloads ; s #\[multilib\] \[multilib\] ; /\[multilib\]/{n;s #Include Include }' /etc/pacman.conf
sleep 1
sudo sed -i "s/ParallelDownloads = 5/ParallelDownloads = 10/" /etc/pacman.conf
echo "Done"
sleep 1

echo '##################################################################'
echo 'Update mirrorlist'
echo '##################################################################'
sleep 1
echo 'pacman -Sy'
pacman -Sy
sleep 1
echo "Done"
sleep 1

echo '##################################################################'
echo 'Set Local time'
echo '##################################################################'
sleep 1
echo "ln -sf /usr/share/zoneinfo/"tzone" " "/etc/localtime"
ln -sf /usr/share/zoneinfo/$tzone /etc/localtime
echo "Done"
sleep 1
echo "hwclock --systohc"
hwclock --systohc
sleep 1
echo "Done"
sleep 1

echo '##################################################################'
echo 'Setting Locale'
echo '##################################################################'

echo "sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen"
sed -i 's #en_US.UTF-8 en_US.UTF-8 ' /etc/locale.gen
sleep 1
echo "locale-gen"
locale-gen
sleep 1
echo "Done"
sleep 1
echo "echo 'LANG=en_US.UTF-8' >> /etc/locale.conf"
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
sleep 1
echo 'KEYMAP=us' >> /etc/vconsole.conf
sleep 1
echo "Done"

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
      	tput sgr0
	else
    	tput setaf 3
    		echo "###############################################################################"
    		echo "##################  Installing package "  $1
    		echo "###############################################################################"
    	tput sgr0
    	pacman -S --noconfirm --needed $1
    fi
}

i=(
#linux header and firmware
linux-headers
sof-firmware
linux-firmware-whence
linux-firmware

#microcode related
intel-ucode
#amd-ucode

#networking and wifi
iwd #intel wireless driver
networkmanager

#mirror setup
reflector

#grub
grub
efibootmgr
#os-prober (uncomment in-case you want to dual-booting)

#limine boot-loaders
#limine

# for systemd boot
#efibootmgr
#os-prober

#optional, make your life easier though
snapper
git
wget
aria2
mdadm #for reading raid structure

# Graphic card, also optional, you can install on next boot anyway, these are for AMD GC
mesa
lib32-mesa
vulkan-radeon
lib32-vulkan-radeon
libva
lib32-libva
libva-utils

# intel integrated graphic
vulkan-intel
lib32-vulkan-intel

# Virtual machine graphic
#mesa
#lib32-mesa
#xf86-video-vmware
#xf86-video-qxl

# To access MS-DOS disks
#mtools
#dosfstools
#ntfs-3g
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

echo '##################################################################'
echo 'Set Hosts'
echo '##################################################################'
sleep 1

#hostnamectl hostname $host
#sleep 1
echo "echo $host >> /etc/hostname"
echo $host >> /etc/hostname
sleep 1

echo "127.0.0.1       localhost
::1             localhost
127.0.1.1       $user	$host" >> /etc/hosts

echo "Done"
sleep 1

echo '##################################################################'
echo 'Compile kernel mkinitcpio'
echo '##################################################################'
sleep 1
echo "mkinitcpio -p linux"
mkinitcpio -p linux
echo "Done"
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
# in truth you no need this much group, wheel is enough
useradd -m -g users -G wheel -s /bin/bash $user
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

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Arch Linux" --removable
sleep 1

#echo '##################################################################'
#echo 'Enable OS_PROBER'
#echo '##################################################################'
#sleep 1

# Uncomment if you want OS-prober
#sudo sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
#sleep 1

echo '##################################################################'
echo 'Create boot config'
echo '##################################################################'
sleep 1

grub-mkconfig -o /boot/grub/grub.cfg
sleep 1

# For Systemd-boot loader
#echo '##################################################################'
#echo 'Create Systemd-boot bootloader'
#echo '##################################################################'
#sleep 1
#bootctl --esp-path=/efi --boot-path=/boot install
#sleep 1
#sed -i 's/#timeout/timeout/' /boot/loader/loader.conf
#sleep 1
#sed -i 's/default/#default/' /boot/loader/loader.conf
#sleep 1
#echo 'default arch-*' >> /boot/loader/loader.conf
#sleep 1
#touch /boot/loader/entries/arch.conf
#sleep 1
#echo 'tittle	Arch Linux
#linux	/vmlinuz-linux
#initrd	/initramfs-linux.img
#options	root=/dev/vda2 rw' >> /boot/loader/entries/arch.conf

# Limine boot
#echo '##################################################################'
#echo 'Create Limine bootloader'
#echo '##################################################################'
#sleep 1
#limine bios-install /dev/sda
#sleep 1

#ROOT_ID="$(grep '/home' /etc/fstab \
#    | awk '{print $1}' \
#    | cut -f 1)" \
#    ; echo $ROOT_ID
#sleep 1

#cp /usr/share/limine/limine-bios.sys /boot
#sleep 1
#mkdir -p /boot/EFI/BOOT
#sleep 1
#cp /usr/share/limine/BOOTX64.EFI /boot/EFI/BOOT/BOOTX64.EFI
#sleep 1
#touch /boot/limine.conf
#sleep 1
#echo "timeout: 5

#/+Arch Linux
#comment: Asura Arch Linux

#	//Arch Linux
#    	protocol: linux
#    	kernel_path: boot():/vmlinuz-linux
#    	kernel_cmdline: root=$ROOT_ID rw rootflags=subvol=@ quiet loglevel=0 quiet intel_iommu=on iommu=pt
#    	module_path: boot():/initramfs-linux.img

#    	//Arch Linux-Fallback
#        protocol: linux
#    	kernel_path: boot():/vmlinuz-linux
#    	kernel_cmdline: root=$ROOT_ID rw rootflags=subvol=@ quiet loglevel=0 quiet intel_iommu=on iommu=pt
#    	module_path: boot():/initramfs-linux-fallback.img

#     	//Snapshots
#      	" >> /boot/limine.conf
#sleep 1
#mkdir -p /etc/pacman.d/hooks
#sleep 1
#touch /etc/pacman.d/hooks/liminedeploy.hook
#sleep 1
#echo "[Trigger]
#Operation = Install
#Operation = Upgrade
#Type = Package
#Target = limine              

#[Action]
#Description = Deploying Limine after upgrade...
#When = PostTransaction
#Exec = /usr/bin/cp /usr/share/limine/BOOTX64.EFI /boot/EFI/BOOT/" >> /etc/pacman.d/hooks/liminedeploy.hook
#sleep 1

echo '##################################################################'
echo 'Enable Network'
echo '##################################################################'
sleep 1

systemctl enable NetworkManager
systemctl enable reflector.service
systemctl enable reflector.timer
exit
