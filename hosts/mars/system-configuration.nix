{ config, pkgs, ... }: {
  imports = [
    ./system/users.nix
  ];

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
    loader = {
      grub.enable = false;
      raspberryPi = {
        enable = true;
        version = 3;
        uboot.enable = true;
        firmwareConfig = ''
          gpu_mem=16
        '';
      };
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  age.secrets = {
    cloudflare-token.file = ../../secrets/cloudflare-token.age;
    lego-token.file = ../../secrets/lego-token.age;
    raroh73-mars-password.file = ../../secrets/raroh73-mars-password.age;
  };

  networking = {
    firewall = {
      enable = true;
      allowedUDPPorts = [ 80 443 ];
      allowedTCPPorts = [ 80 443 ];
    };
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

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-token.path;
    domains = [ "raroh73.xyz" ];
    proxied = true;
  };

  security.acme = {
    acceptTerms = true;
    certs = {
      "raroh73.xyz" = {
        credentialsFile = config.age.secrets.lego-token.path;
        dnsProvider = "cloudflare";
        email = "me@raroh73.xyz";
        extraDomainNames = [ "www.raroh73.xyz" ];
      };
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "raroh73.xyz" = {
        serverAliases = [ "www.raroh73.xyz" ];
        useACMEHost = "raroh73.xyz";
        extraConfig = ''
          root * /srv/www/raroh73_xyz
          file_server
        '';
      };
    };
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

  environment.shells = with pkgs; [ nushell ];
  environment.systemPackages = with pkgs; [ libraspberrypi ];

  system.stateVersion = "22.11";
}
