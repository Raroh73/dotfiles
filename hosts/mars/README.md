
# Mars

## Installation

```sh
nix build .#mars-install
sudo dd if=result/sd-image/mars.img of=/dev/sdc bs=4096 conv=fsync status=progress
```

## First configuration

```sh
nixos-rebuild --flake .#mars --target-host mars --use-remote-sudo switch
```
