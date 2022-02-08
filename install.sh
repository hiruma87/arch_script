echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nStarting NTP Daemon...\n"

timedatectl set-ntp true
sleep 10

echo -e "\nDone.\n\n"

echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1

# format partition 2
mkfs.ext4 /dev/sda2

echo -e "\nDone.\n\n"

sleep 3

echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nMounting Partitions...\n"
sleep 3
# mount the ROOT partition on "/mnt"
mount /dev/sda2 /mnt
sleep 3
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

echo -e "\nPerforming Pacstrap Operation...\n"
sleep 3
# edit and adjust the "pkgs" file for desired packages (don't worry about any extra white spaces or new lines or comments as they will be omitted using sed and tr)
echo
echo "########################################################"
echo "Installing Packages"
echo "########################################################"
echo

i=(
base
linux
linux-firmware
vim
bash-completion
)
count = 0
for pkg in "${i[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	echo "Installing package nr.  "$count " " $i
	echo "################################################################"
	pacstrap /mnt $pkg
  sleep 3
done

echo
echo "Done"
echo

echo -e "\nDone.\n\n"
sleep 3
echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nGenerating FSTab...\n"
echo
genfstab -U /mnt >> /mnt/etc/fstab
echo
echo -e "\nDone.\n\nBase installation is now complete.\n\n"
sleep 3
arch-chroot /mnt
