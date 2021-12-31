pacman -S udisks2 udiskie

echo '# UDISKS_FILESYSTEM_SHARED
# ==1: mount filesystem to a shared directory (/media/VolumeName)
# ==0: mount filesystem to a private directory (/run/media/$USER/VolumeName)
# See udisks(8)
ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' >> /etc/udev/rules.d/99-udisks2.rules

echo 'D /media 0755 root root 0 -' >> /etc/tmpfiles.d/media.conf

echo '#    Path                  Mode UID  GID  Age Argument
w    /proc/acpi/wakeup     -    -    -    -   USBE' >> /etc/tmpfiles.d/disable-usb-wake.conf

echo '### Automatically switch to newly-connected devices
load-module module-switch-on-connect' >> /etc/pulse/default.pa

echo 'blacklist pcspkr' >> /etc/modprobe.d/nobeep.conf
