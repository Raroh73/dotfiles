{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "cma=256M" ];
    loader = {
      grub.enable = false;
      raspberryPi = {
        enable = true;
        firmwareConfig = ''
          gpu_mem=16
        '';
        uboot = {
          enable = true;
          configurationLimit = 8;
        };
        version = 3;
      };
    };
    tmp.cleanOnBoot = true;
  };
}
