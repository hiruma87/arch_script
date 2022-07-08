#!/bin/bash
#set -e
###############################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


tput setaf 5;
echo "################################################################"
echo "Run installation script"
echo "################################################################"
echo;tput sgr0

sh 2_xorg.sh
sh 3_graphic.sh
sh 4_misc.sh
sh 5_network.sh
sh 6_audio.sh
sh 7_bluetooth.sh
sh 8_browser.sh
sh 9_printer.sh
sh 10_wine.sh
sh 11_fonts.sh

###############################################################################


tput setaf 5;
echo "################################################################"
echo "Enabling lightdm as display manager"
echo "################################################################"
echo;tput sgr0

sudo systemctl enable lightdm.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
