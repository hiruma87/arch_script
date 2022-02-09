echo '#######################################################'
echo 'Enter superuser'
echo '#######################################################'
sleep 2
su
sleep 2
cd /root
sleep 2
echo '#################################################################'
echo 'Creating a swapfile'
echo '#################################################################'
sleep 2
fallocate -l 4096MB /swapfile
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
echo
echo 'Done'
sleep 2
echo '#################################################################'
echo 'Create swap fstab entry'
echo '#################################################################'
sleep 2
cp /etc/fstab /etc/fstab.bak
sleep 2
echo
echo 'Done'
sleep 2
echo '/swapfile none swap defaults 0 0' >> /etc/fstab
sleep 2
echo
echo 'Done'
sleep 2
cat /etc/fstab
sleep 2
swapon -a
sleep 2
echo
echo 'Done'
sleep 2
free -m
sleep 2
exit
