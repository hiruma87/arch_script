# https://www.archlinuxuser.com/2013/06/how-to-setup-time-date-gui-on-archlinux.html
sudo pacman -S gnome-control-center --noconfirm --needed
sudo echo '[Desktop Entry]
Name=Time Settings
Exec=gnome-control-center datetime
Icon=preferences-system
Type=Application
Categories=GTK;Settings;DesktopSettings;' >> /usr/share/applications/timesettings.desktop
