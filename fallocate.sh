fallocate -l 4GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
grub-mkconfig -o /boot/grub/grub.cfg
