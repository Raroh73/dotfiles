#!/usr/bin/env bash

# Configure NixOS
git clone https://github.com/Raroh73/dotfiles.git
cd dotfiles
sudo nixos-rebuild --flake . boot
rm -fr dotfiles
echo "Configured NixOS!"
