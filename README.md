# arch_script
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

2, Installing base arch
    - At the end of btrfs_part.sh, it will automatically download the install.sh script
    - The scrpt will set the ntp and generate fstab file
    - To manually download the install file
   ```bash
    curl https://raw.githubuser.com/hiruma87/arch_script/main/install.sh -o install.sh
   ```
