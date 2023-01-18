
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nFormatting Partitions...\n"
sleep 1

# wipe file system of the installation destination disk
wipefs --all /dev/sda
sleep 1

# create a new EFI system partition of size 512 MiB with partition label as "BOOT"
sgdisk -n 0:0:+300M -t 0:ef00 /dev/sda
#sgdisk -n 0:0:+300M -t 0:ef00 -c 0:BOOT /dev/sda
sleep 1

# create a new Linux x86-64 root (/) partition on the remaining space with partition label as "ROOT"
#sgdisk -n 0:0:+200G -t 0:8304 -c 0:ROOT /dev/sda
sgdisk -n 0:0:0 -t 0:8304 -c /dev/sda
#sgdisk -n 0:0:0 -t 0:8304 -c 0:ROOT /dev/sda
sleep 1
# Create a new linux home partition
#sgdisk -n 0:0:0 -t 0:8304 -c 0:HOME /dev/sda
#sleep 3
mkfs.fat -F 32 /dev/sda1
sleep 1
mkfs.btrfs -f /dev/sda2
sleep 1
#mkfs.btrfs -f /dev/sda3
mount /dev/sda2 /mnt
sleep 1
btrfs sub cr /mnt/@
sleep 1
#umount /mnt
#sleep 3
#mount /dev/sda3 /mnt
#sleep 3
btrfs sub cr /mnt/@home
sleep 1
umount /mnt
sleep 3
mount -o noatime,space_cache=v2,ssd,compress=zstd,discard=async,subvol=@ /dev/sda2 /mnt
sleep 1
mkdir -p /mnt/{boot,home}
sleep 1
mount /dev/sda1 /mnt/boot
sleep 1
mount -o noatime,space_cache=v2,ssd,compress=zstd,discard=async,subvol=@home /dev/sda2 /mnt/home
lsblk
sleep 1
echo -e "\nDone.\n\n"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 1
curl https://raw.githubusercontent.com/hiruma87/arch_script/main/install.sh -o install.sh
sleep 1
chmod +x install.sh
sleep 1
