sudo pacman -S gnome-control-center
sudo echo '[Desktop Entry]
Name=Time Settings
Exec=gnome-control-center datetime
Icon=preferences-system
Type=Application
Categories=GTK;Settings;DesktopSettings;' >> '/usr/share/applications/timesettings.desktop'
