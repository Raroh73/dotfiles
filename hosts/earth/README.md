# Earth

## Installation

```sh
# Change to root account
sudo -i

# Create partitions
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- mkpart primary 512MiB -8GiB
parted /dev/sda -- mkpart primary linux-swap -8GiB 100%
parted /dev/sda -- set 1 esp on

# Format partitions
mkfs.fat -F32 -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2
mkswap -L swap /dev/sda3

# Install NixOS
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
nixos-generate-config --root /mnt
nixos-install --no-root-passwd
```
