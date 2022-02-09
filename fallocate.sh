echo '#################################################################'
echo 'Creating a swapfile'
echo '#################################################################'
sleep 2
fallocate -l 4GB /swapfile
sleep 2
echo
echo 'Done'
sleep 2
echo '#################################################################'
echo 'Activate swap'
echo '#################################################################'
sleep 2
chmod 600 /swapfile
sleep 2
mkswap /swapfile
sleep 2
echo '#################################################################'
echo 'Create swap boot entry'
echo '#################################################################'
sleep 2
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
sleep 2
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2
