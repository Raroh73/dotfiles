# Sol

## Installation

```sh
# Change to root account
sudo -i

# Create partitions
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
parted /dev/sda -- mkpart primary 512MiB -1GiB
parted /dev/sda -- mkpart primary linux-swap -1GiB 100%
parted /dev/sda -- set 1 esp on

# Format partitions
mkfs.fat -F32 -n boot /dev/vda1
mkfs.ext4 -L nixos /dev/vda2
mkswap -L swap /dev/vda3

# Install NixOS
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/vda3
nixos-generate-config --root /mnt
curl https://raw.githubusercontent.com/Raroh73/dotfiles/main/hosts/sol/install-configuration.nix -o /mnt/etc/nixos/configuration.nix
nixos-install --no-root-passwd
reboot
git clone https://github.com/Raroh73/dotfiles.git
cd dotfiles
sudo nixos-rebuild boot --flake .
sudo reboot
```
