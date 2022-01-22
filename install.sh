echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nStarting NTP Daemon...\n"

timedatectl set-ntp true

echo -e "\nDone.\n\n"

echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nFormatting Partitions...\n"

# wipe file system of the installation destination disk
wipefs --all /dev/sda

# create a new EFI system partition of size 512 MiB with partition label as "BOOT"
sgdisk -n 0:0:+512M -t 0:ef00 -c 0:BOOT /dev/sda

# create a new Linux LVM partition on the remaining space with partition label as "ROOT"
sgdisk -n 0:0:0 -t 0:8304 -c 0:ROOT /dev/sda

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1

# format partition 2
mkfs.ext4 /dev/sda2

echo -e "\nDone.\n\n"


echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
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
echo -e "\nPerforming Pacstrap Operation...\n"

# edit and adjust the "pkgs" file for desired packages (don't worry about any extra white spaces or new lines or comments as they will be omitted using sed and tr)
echo
echo "########################################################"
echo "Installing Packages"
echo "########################################################"
echo

PKGS=(
base
linux
linux-zen
lvm2
linux-firmware
vim
bash-completion
)

count=0
for PKG in "${PKGS[@]}" ; do
  count=$[count+1]
  echo "########################################################"
	echo "Installing: $count ${PKG}"
  echo "########################################################"
	pacstrap /mnt "$PKG"
done

echo
echo "Done"
echo

echo -e "\nDone.\n\n"

echo "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nGenerating FSTab...\n"
echo
genfstab -U /mnt >> /mnt/etc/fstab
echo
echo -e "\nDone.\n\nBase installation is now complete.\n\n"

arch-chroot /mnt
