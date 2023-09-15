_: {
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };

  boot.kernelParams = [ "cma=256M" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "mars";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$/kpTtNX40QPSPs3I5vnO80$ZsE8ej9u6.5ok0DCbRTZ5T.6yaHuM1eb5R9.RxQ7kV8";
      };
      root.hashedPassword = "!";
    };
  };

  security.sudo.extraRules = [{
    groups = [ "wheel" ];
    commands = [
      {
        command = "/run/current-system/sw/bin/nix-env";
        options = [ "NOPASSWD" ];
      }
      {
        command = "/nix/store/*/bin/switch-to-configuration";
        options = [ "NOPASSWD" ];
      }
    ];
  }];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

  sdImage = {
    compressImage = false;
    imageName = "mars.img";
  };

  system.stateVersion = "22.11";
}
