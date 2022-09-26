
sudo echo 'fastestmirror=true
deltarpm=true
max_parallel_downloads=5
defaultyes=true' >> sudo nano /etc/dnf/dnf.conf
sleep 1

sudo dnf update -y
sleep 1

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sleep 1

sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sleep 1

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sleep 1

sudo dnf install akmod-nvidia neofetch git vim udiskie -y
sleep 1

echo '# UDISKS_FILESYSTEM_SHARED
# ==1: mount filesystem to a shared directory (/media/VolumeName)
# ==0: mount filesystem to a private directory (/run/media/$USER/VolumeName)
# See udisks(8)
ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' >> /etc/udev/rules.d/99-udisks2.rules
sleep 1

echo 'D /media 0755 root root 0 -' >> /etc/tmpfiles.d/media.conf
sleep 1

echo '#    Path                  Mode UID  GID  Age Argument
w    /proc/acpi/wakeup     -    -    -    -   USBE' >> /etc/tmpfiles.d/disable-usb-wake.conf
sleep 1

echo 'blacklist pcspkr' >> /etc/modprobe.d/nobeep.conf
