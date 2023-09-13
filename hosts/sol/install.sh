#!/usr/bin/env bash

# Create partitions
parted /dev/vda -- mklabel msdos
parted /dev/vda -- mkpart primary 1MB -1GB
parted /dev/vda -- mkpart primary linux-swap -1GB 100%
parted /dev/vda -- set 1 esp on
partprobe /dev/vda
echo "Created partitions!"

# Format partitions
mkfs.ext4 -L nixos /dev/vda1
while [ ! -e "/dev/disk/by-label/nixos" ]; do sleep 1; done
mkswap -L swap /dev/vda2
while [ ! -e "/dev/disk/by-label/swap" ]; do sleep 1; done
echo "Formatted partitions!"

# Mount partitions
mount /dev/disk/by-label/nixos /mnt
swapon /dev/disk/by-label/swap
echo "Mounted partitions!"

# Install NixOS
nixos-generate-config --root /mnt
curl https://raw.githubusercontent.com/Raroh73/dotfiles/main/hosts/sol/install-configuration.nix -o /mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd
echo "Installed NixOS!"
