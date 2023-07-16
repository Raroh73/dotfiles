{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "cma=256M" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible = {
          enable = true;
          configurationLimit = 8;
      };
    };
    tmp.cleanOnBoot = true;
  };
}
