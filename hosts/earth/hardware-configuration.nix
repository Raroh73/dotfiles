{ pkgs, ... }: {
  imports = [
    ./hardware/boot.nix
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  zramSwap.enable = true;

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    xone.enable = true;
  };
}
