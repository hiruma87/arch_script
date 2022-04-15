echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nFormatting Partitions...\n"
sleep 3

# wipe file system of the installation destination disk
wipefs --all /dev/sda
sleep 3

# create a new EFI system partition of size 512 MiB with partition label as "BOOT"
sgdisk -n 0:0:+512M -t 0:ef00 -c 0:BOOT /dev/sda
sleep 3

# create a new Linux x86-64 root (/) partition on the remaining space with partition label as "ROOT"
sgdisk -n 0:0:+150G -t 0:8304 -c 0:ROOT /dev/sda
sleep 3
# Create a new linux home partition
sgdisk -n 0:0:0 -t 0:8304 -c 0:HOME /dev/sda

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1
sleep 3

# format partition 2
mkfs.ext4 /dev/sda2
sleep 3

#format patition 3
mkfs.ext4 /dev/sda3

echo -e "\nDone.\n\n"
sleep 3
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

echo -e "\nMounting Partitions...\n"
sleep 3
# mount the ROOT partition on "/mnt"
mount /dev/sda2 /mnt
sleep 3
#mount home partition
mkdir -p /mnt/home
mount /dev/sda3 /mnt/home

# create necessary directories
mkdir -p /mnt/boot/EFI
sleep 3
# mount the EFI partition on "/mnt/boot"
mount /dev/sda1 /mnt/boot/EFI
sleep 3
lsblk
sleep 3
echo -e "\nDone.\n\n"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 3
