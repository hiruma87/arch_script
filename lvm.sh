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
sgdisk -n 0:0:0 -t 0:8e00 -c 0:ROOT /dev/sda

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1

# Create logical volume
pvcreate --dataalignment 1m /dev/sda2

# Create LVM group
vgcreate volg0 /dev/sda2

# Give partition size
lvcreate -l 100%FREE volg0 -n lv_root

# Give mod to vol group
modprobe dm_mod

# Scan Vol group
vgscan

# Activate Vol group
vgchange -ay

# format partition 2 as EXT4 with file system label "System"
mkfs.ext4 /dev/volg0/lv_root

echo -e "\nDone.\n\n"

echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nModifying Pacman Configuration...\n"

# enable options "color", "ParallelDownloads", "multilib (32-bit) repository"
sed -i 's/#Color/Color/ ; s/#ParallelDownloads/ParallelDownloads/ ; s/#[multilib]/[multilib]/' /etc/pacman.conf

pacman -Syy

echo -e "\nDone.\n\n"

echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nMounting Partitions...\n"

# mount the ROOT partition on "/mnt"
mount /dev/volg0/lv_root /mnt

# create necessary directories
mkdir -p /mnt/boot/EFI

# mount the EFI partition on "/mnt/boot"
mount /dev/sda1 /mnt/boot/EFI

lsblk

echo -e "\nDone.\n\n"
