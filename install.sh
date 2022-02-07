echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nStarting NTP Daemon...\n"

timedatectl set-ntp true

echo -e "\nDone.\n\n"
sleep 10
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1

# format partition 2
mkfs.ext4 /dev/sda2

echo -e "\nDone.\n\n"


echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 10
echo -e "\nMounting Partitions...\n"

# mount the ROOT partition on "/mnt"
mount /dev/sda2 /mnt

# create necessary directories
mkdir -p /mnt/boot/EFI

# mount the EFI partition on "/mnt/boot"
mount /dev/sda1 /mnt/boot/EFI

lsblk

echo -e "\nDone.\n\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 10
echo -e "\nPerforming Pacstrap Operation...\n"

# edit and adjust the "pkgs" file for desired packages (don't worry about any extra white spaces or new lines or comments as they will be omitted using sed and tr)
echo
echo "########################################################"
echo "Installing Packages"
echo "########################################################"
echo

pacstrap /mnt base linux linux-firmware linux-firmware-qcom vim bash-completion

echo
echo "Done"
echo

echo -e "\nDone.\n\n"
sleep 10
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nGenerating FSTab...\n"
echo
genfstab -U /mnt >> /mnt/etc/fstab
echo
echo -e "\nDone.\n\nBase installation is now complete.\n\n"
sleep 10
arch-chroot /mnt
