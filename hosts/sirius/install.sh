#!/usr/bin/env bash

# Create partitions
curl https://raw.githubusercontent.com/Raroh73/dotfiles/main/hosts/sirius/disko-configuration.nix -o /tmp/disko-configuration.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko-configuration.nix

# Install NixOS
nixos-generate-config --no-filesystems --root /mnt
curl https://raw.githubusercontent.com/Raroh73/dotfiles/main/hosts/sirius/install-configuration.nix -o /mnt/etc/nixos/configuration.nix
mv /tmp/disko-configuration.nix /mnt/etc/nixos
nixos-install --no-root-passwd
echo "Installed NixOS!"
