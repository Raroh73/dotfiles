{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };

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
        hashedPassword = "$y$j9T$E7B.wD/rB2Z6LnU05C86N1$tREsxNWhOg2Zul8lRrSaUvNX3icaHcV1Ac3QfMRAFXA";
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

  system.stateVersion = "22.11";
}
