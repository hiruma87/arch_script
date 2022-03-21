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
sgdisk -n 0:0:0 -t 0:8304 -c 0:ROOT /dev/sda
sleep 3

# format partition 1 as FAT32 with file system label "ESP"
mkfs.fat -F 32 /dev/sda1
sleep 3

# format partition 2
mkfs.ext4 /dev/sda2
sleep 3

echo -e "\nDone.\n\n"
sleep 3


echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 3