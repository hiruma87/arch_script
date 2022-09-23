sudo dnf update --y

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo echo 'fastestmirror=true
deltarpm=true
max_parallel_downloads=5
defaultyes=true' >> sudo nano /etc/dnf/dnf.conf

sudo dnf install akmod-nvidia --y
