Installation
------------
Before installation, you should install DKMS support. Depending on which Linux distribution you use, you can run one of the following commands as root or using `sudo`:

* On Debian, Ubuntu, or Mint:   `apt-get install dkms`
* On Fedora:                    `dnf install dkms`
* On Arch Linux:                `pacman -S dkms`

Next, clone the source code.

    git clone https://github.com/hiruma87/hid-sony-fix
    cd hid-sony-fix

Then run the following commands as root or using `sudo`.

    dkms add .
    dkms build hid-sony-fix/1.14
    dkms install hid-sony-fix/1.14

Then add blacklist to modprobe

'sudo echo "blacklist hid_sony" >> /usr/lib/modprobe.d/hid-sony-blacklist.conf'

Uninstallation
--------------

To remove fully, run the following commands as root or using `sudo`.

    modprobe -r hid_sony-fix
    dkms uninstall hid-sony-fix/1.14
    dkms remove hid-sony-fix/1.14
    rm -rf /usr/src/hid-sony-*

ddLicense
-------

    HID driver for Nintendo Switch Joy-Cons and Pro Controllers

    Copyright (c) 2019-2021 Daniel J. Ogorchock <djogorchock@gmail.com>
    Portions Copyright (c) 2020 Nadia Holmquist Pedersen <nadia@nhp.sh>
    Copyright (c) 2022 Emily Strickland <linux@emily.st>

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301, USA.
