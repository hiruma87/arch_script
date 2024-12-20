
echo "-------------------------------------------------------------------------------------------------------------------"
echo -e "\nFormatting Partitions...\n"
sleep 1

# wipe file system of the installation destination disk
wipefs --all /dev/sda
sleep 1
sgdisk -g /dev/sda
sleep 1
# create a new EFI system partition of size 512 MiB with partition label as "BOOT"
sgdisk -n 0:0:+1024M -t 0:ef00 -c 0:BOOT /dev/sda
sleep 1
# create a new Linux x86-64 root (/) partition on the remaining space with partition label as "ROOT"
sgdisk -n 0:0:0 -t 0:8304 -c 0:ROOT /dev/sda
sleep 1
# Formatiing the partitiions and mount to /mnt
mkfs.fat -F 32 /dev/sda1
sleep 1
mkfs.btrfs -f /dev/sda2
sleep 1
mount /dev/sda2 /mnt
sleep 1
# create subvolumes
btrfs sub cr /mnt/@
sleep 1
btrfs sub cr /mnt/@home
sleep 1
btrfs sub cr /mnt/@swap
sleep 1
btrfs sub cr /mnt/@.snapshots
sleep 1
btrfs sub cr /mnt/@log
sleep 1
btrfs sub cr /mnt/@cache
sleep 1
btrfs sub cr /mnt/@opt
sleep 1
# remount partition to subvolume
umount /mnt
sleep 1
mount -o subvol=@,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt
sleep 1
mkdir -p /mnt/{boot,home,opt,.swap,.snapshots}
sleep 1
mkdir -p /mnt/var/{log,cache}
sleep 1
# mount my raid drive
mkdir -p /mnt/media/raid0
sleep 1
mount /dev/md127 /mnt/media/raid0
sleep 1
# mount all the partitions and subvolume
mount /dev/sda1 /mnt/boot
sleep 1
mount -o subvol=@home,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt/home
sleep 1
mount -o subvol=@swap,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt/.swap
sleep 1
mount -o subvol=@.snapshots,noatime,compress=zstd,discard=async /dev/sda2 /mnt/.snapshots
sleep 1
mount -o subvol=@log,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt/var/log
sleep 1
mount -o subvol=@cache,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt/var/cache
sleep 1
mount -o subvol=@opt,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt/opt
sleep 1
# Confirming the mount
lsblk
sleep 1
echo -e "\nDone.\n\n"
echo "-------------------------------------------------------------------------------------------------------------------"
sleep 1
# Next script
curl https://raw.githubusercontent.com/hiruma87/arch_script/main/install.sh -o install.sh
sleep 1
chmod +x install.sh
sleep 1
