# arch_script (not encrypted)
## Credit
DomiLuebben: [DomiLuebben Archmatic](https://github.com/DomiLuebben/ArchMatic)

erikdubois and Arcolinux: [Arco Linux](https://github.com/arcolinuxd)

Arch Wiki: [Arch Installation Guide](https://wiki.archlinux.org/title/Installation_guide)

## Installation
1. Download the btrfs_part.sh
    - the files will create btrfs partitions for your drive
    - Nake sure to modify the partions according to your taste or requirements via vim or nano
   ```bash
    curl https://raw.githubuser.com/hiruma87/arch_script/main/btrfs_part.sh -o btrfs_part.sh
   ```
    - you can rename he file during download by changing the name after the -o (e.g -o btrfs.sh)
    - just make sure it is .sh so you can run the script
    - To run the partition script run
   ```bash
    sh btrfs_part.sh
   ```
    - Another way, you can set the file as executable by
    ```bash
    chmod +x btrfs_part.sh
    ```
    - Then run it using
    ```bash
    ./btrfs_part.sh
    ```

2. Installing base arch
   - At the end of btrfs_part.sh, it will automatically download the install.sh script
   - The scrpt will set the timedatectl install base programs (base, linux) and generate fstab file
   - To manually download the install file
   ```bash
    curl https://raw.githubuser.com/hiruma87/arch_script/main/install.sh -o install.sh
   ```
   - The file already made as executable, so you can run it using either of this command
     ```bash
     ./install.sh
     ```
     or
     ```bash
     sh install.sh
     ```

3. Arch-chroot and setting up Arch
   - The install script will automatically download a preinstall script and bring you to chroot
     ```bash
     arch-chroot /mnt
     ```
   - The preinstall.sh file will setup up the user,password, timezone, grub and other dependencies that will help you to boot into arch
   - To manually download the preinstall file
     ```bash
     curl https://raw.githubusercontent.com/hiruma87/arch_script/main/preinstall.sh -o preinstall.sh
     ```
   - Make sure you modify the file eg. the graphic driver part and os-prober incase you want to dual boot
   - Run the script by
     ```bash
     sh preinstall.sh
     ```
     or
     ```bash
     ./preisntall.sh
     ```
  
5. Exit and reboot
   - Exit the chroot mode by typing
     ```bash
     exit
     ```
   - Umount
     ```bash
     umount -a
     ```
   - There will be error saying some partition busy, ignore them
   - reboot by typing
     ```bash
     reboot
     ```
   - Take out your boot drive (USB, CD)
   - And enjoy using Arch, well there wouldn't be DE, you will customize them to your taste
