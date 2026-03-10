echo "-------------------------------------------------------------------------------------------------------------------"
echo -e "\nbackup from snapper...\n"
sleep 1

mount -o subvol=@,noatime,compress=zstd:1,discard=async /dev/sda2 /mnt
sleep 1
# mount my raid drive
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
pacman -Syu
sleep 1
grub-mkconfig -o /boot/grub/grub.cfg
sleep 1
