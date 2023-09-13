#!/usr/bin/env bash

# Create partitions
parted /dev/vda -- mklabel gpt
parted /dev/vda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/vda -- mkpart primary 512MiB -1GiB
parted /dev/vda -- mkpart primary linux-swap -1GiB 100%
parted /dev/vda -- set 1 esp on
partprobe /dev/vda
echo "Created partitions!"

# Format partitions
mkfs.fat -F32 -n boot /dev/vda1
while [ ! -e "/dev/disk/by-label/boot" ]; do sleep 1; done
mkfs.ext4 -L nixos /dev/vda2
while [ ! -e "/dev/disk/by-label/nixos" ]; do sleep 1; done
mkswap -L swap /dev/vda3
while [ ! -e "/dev/disk/by-label/swap" ]; do sleep 1; done
echo "Formatted partitions!"

# Mount partitions
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/disk/by-label/swap
echo "Mounted partitions!"

# Install NixOS
nixos-generate-config --root /mnt
curl https://raw.githubusercontent.com/Raroh73/dotfiles/main/hosts/sol/install-configuration.nix -o /mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd
echo "Installed NixOS!"
