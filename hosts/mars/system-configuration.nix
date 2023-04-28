{ config, pkgs, ... }: {
  nix = {
    extraOptions = ''
      keep-derivations = true
      keep-outputs = true
    '';
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "cma=256M" ];
    loader.raspberryPi = {
      enable = true;
      version = 3;
      uboot.enable = true;
      firmwareConfig = ''
        gpu_mem=16
      '';
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  age.secrets = {
    raroh73-mars-password.file = ../../secrets/raroh73-mars-password.age;
  };

  networking = {
    firewall.enable = true;
    hostName = "mars";
    nameservers = [ "193.110.81.0#dns0.eu" "2a0f:fc80::#dns0.eu" "185.253.5.0#dns0.eu" "2a0f:fc81::#dns0.eu" ];
    networkmanager.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    extraConfig = "DNSOverTLS=yes";
  };

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        passwordFile = config.age.secrets.raroh73-mars-password.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQi95k0yKYkgnH8r3COiPPyBNqi6pdxyHnGl3qgsshP raroh73@mars" ];
        packages = with pkgs; [ git ];
      };
      root.hashedPassword = "!";
    };
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  zramSwap.enable = true;

  environment.systemPackages = with pkgs; [ libraspberrypi ];

  system.stateVersion = "22.11";
}
