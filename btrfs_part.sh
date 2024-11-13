
echo "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\nFormatting Partitions...\n"
sleep 1

# wipe file system of the installation destination disk
wipefs --all /dev/sda
sleep 1

# create a new EFI system partition of size 512 MiB with partition label as "BOOT"
sgdisk -n 0:0:+1024M -t 0:ef00 /dev/sda
#sgdisk -n 0:0:+300M -t 0:ef00 -c 0:BOOT /dev/sda
sleep 1

# create a new Linux x86-64 root (/) partition on the remaining space with partition label as "ROOT"
#sgdisk -n 0:0:+200G -t 0:8304 -c 0:ROOT /dev/sda
sgdisk -n 0:0:0 -t 0:8304 /dev/sda
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
btrfs sub cr /mnt/@.swap
sleep 1
btrfs sub cr /mnt/@.snapshots
sleep 1
btrfs sub cr /mnt/@cache
sleep 1
btrfs sub cr /mnt/@log
sleep 1
btrfs sub cr /mnt/@home/@.snapshots
sleep 1
btrfs sub cr /mnt/@opt
sleep 1
btrfs sub cr /mnt/@crash
sleep 1
btrfs su cr /mnt/@AccountsService
sleep 1
btrfs su cr /mnt/@lightdm
sleep 1
btrfs su cr /mnt/@lightdm-data
sleep 1
#btrfs su cr /mnt/@sddm (or gdm)
btrfs su cr /mnt/@tmp
sleep 1
btrfs su cr /mnt/@images
sleep 1
btrfs su cr /mnt/@spool
sleep 1
btrfs su cr /mnt/@root
sleep 1
btrfs su cr /mnt/@var/@tmp
sleep 1
umount /mnt
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@ /dev/sda2 /mnt
sleep 1
mkdir -p /mnt/{boot/efi,home/.snapshots,.swap,.snapshots,root,tmp,opt}
#mkdir -p /mnt/{boot/efi,home,.swap}
sleep 3
mkdir -p /mnt/var/{log,cache,crash,tmp,spool,lib/{AccountsService,lightdm,lightdm-data,libvirt/images}}
sleep 3
mount /dev/sda1 /mnt/boot/efi
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@home /dev/sda2 /mnt/home
sleep 1
mount -o noatime,,compress=zstd,discard=async,subvol=@root /dev/sda2 /mnt/root
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@tmp /dev/sda2 /mnt/tmp
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@opt /dev/sda2 /mnt/opt
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@.swap /dev/sda2 /mnt/.swap
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@.snapshots /dev/sda2 /mnt/.snapshots
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@log /dev/sda2 /mnt/var/log
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@cache /dev/sda2 /mnt/var/cache
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@crash /dev/sda2 /mnt/var/crash
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@spool /dev/sda2 /mnt/var/spool
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@var/@tmp /dev/sda2 /mnt/var/tmp
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@home/@.snapshots /dev/sda2 /mnt/home/.snapshots
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@AccountsService /dev/sda2 /mnt/var/lib/AccountsService
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@lightdm /dev/sda2 /mnt/var/lib/lightdm
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@lightdm-data /dev/sda2 /mnt/var/lib/lightdm-data
sleep 1
mount -o noatime,compress=zstd,discard=async,subvol=@images /dev/sda2 /mnt/var/lib/libvirt/images
sleep 1
lsblk
sleep 1
echo -e "\nDone.\n\n"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
sleep 1
curl https://raw.githubusercontent.com/hiruma87/arch_script/main/install.sh -o install.sh
sleep 1
chmod +x install.sh
sleep 1
