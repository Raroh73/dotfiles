{ pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "sr_mod"
        "virtio_blk"
        "virtio_pci"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 8;
      };
      efi.canTouchEfiVariables = true;
    };
    tmp.cleanOnBoot = true;
  };
}
