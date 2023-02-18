{ pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "firewire_ohci"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ ];
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        consoleMode = "max";
        editor = false;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
