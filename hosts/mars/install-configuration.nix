{ pkgs, ... }: {
  boot = {
    kernelParams = [ "cma=256M" ];
    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  hardware.enableRedistributableFirmware = true;

  networking = {
    firewall.enable = true;
    hostName = "mars";
    networkmanager.enable = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      trusted-users = [ "@wheel" "root" ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  sdImage = {
    compressImage = false;
    imageName = "mars.img";
  };

  security.sudo.extraRules = [
    {
      commands = [
        {
          command = "/nix/store/*/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-env";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }
  ];

  services = {
    fail2ban.enable = true;
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  system.stateVersion = "22.11";

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$G0rX4W6eqrwz2gNOSuM9/1$M1SiWyYp.Xq4u0GPAJxZYeW0CJ6q3BzIJ2ubkgi6DP3";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+aFhxW7Q8vLMPCS8jPFtqUUePL6Ks9213gsEOJbIOz raroh73@mars" ];
      };
      root.hashedPassword = "!";
    };
  };

  zramSwap.enable = true;
}
