echo 'Disable greeting manager'
sudo systemctl disable sddm.service

sudo pacman -D asdeps $(pacman -Qqe)
sudo pacman -D --asexplicit base linux linux-firmware git vim intel-ucode

#Need to change to su
su
#Remove all dependency
pacman -Qttdq | pacman -Rns -
#cd to root
cd /
# Check the preinstall.sh
# comment all the setting until the pacman install
# comment the user create and sudoer
