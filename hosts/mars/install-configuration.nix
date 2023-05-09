{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
    groups.deploy = { };
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "deploy" "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$E7B.wD/rB2Z6LnU05C86N1$tREsxNWhOg2Zul8lRrSaUvNX3icaHcV1Ac3QfMRAFXA";
        packages = with pkgs; [ git ];
      };
      root.hashedPassword = "!";
    };
  };

  security.sudo.extraRules = [
    {
      groups = [ "deploy" ];
      commands = [
        {
          command = "/nix/store/*/activate-rs";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/rm /tmp/deploy-rs-canary-*";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

  system.stateVersion = "22.11";
}
