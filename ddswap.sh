echo '#######################################################'
echo 'Enter superuser'
echo '#######################################################'
sleep 2
su
sleep 2
cd /root
sleep 2
echo '#######################################################'
echo 'Create a swapfile'
echo '#######################################################'
sleep 2
dd if=/dev/zero of=/swapfile bs=1M count=2048 status=progress
sleep 2
chmod 600 /swapfile
sleep 2
mkswap /swapfile
sleep 2
cp /etc/fstab /etc/fstab.bak
sleep 2
echo '/swapfile none swap sw 0 0' >> /etc/fstab
sleep 2
cat /etc/fstab
sleep 2
swapon -a
sleep 2
free -m
sleep 2
exit
