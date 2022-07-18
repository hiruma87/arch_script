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
echo "Installing Xorg"
echo "################################################################"
echo;tput sgr0
sh 2_xorg.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Graphic Card Driver"
echo "################################################################"
echo;tput sgr0
sh 3_graphic.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Misc Program"
echo "################################################################"
echo;tput sgr0
sh 4_misc.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Network Open VPN"
echo "################################################################"
echo;tput sgr0
sh 5_network.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Audio Driver"
echo "################################################################"
echo;tput sgr0
sh 6_audio.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Bluetooth Driver"
echo "################################################################"
echo;tput sgr0
sh 7_bluetooth.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Web Browser"
echo "################################################################"
echo;tput sgr0
sh 8_browser.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Printer Driver"
echo "################################################################"
echo;tput sgr0
sh 9_printer.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Wine"
echo "################################################################"
echo;tput sgr0
sh 10_wine.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Installing Fonts"
echo "################################################################"
echo;tput sgr0
sh 11_fonts.sh
echo "Done"

tput setaf 5;
echo "################################################################"
echo "Adding Time Date GUI"
echo "################################################################"
echo;tput sgr0
sh timedate.sh
echo "Done"
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