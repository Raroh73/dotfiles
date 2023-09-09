{ pkgs, ... }: {
  imports = [
    ./system/acme.nix
    ./system/age.nix
    ./system/boot.nix
    ./system/cloudflare-dyndns.nix
    ./system/nextcloud.nix
    ./system/nginx.nix
    ./system/users.nix
    ./system/webhook.nix
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
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  networking = {
    firewall = {
      enable = true;
      allowedUDPPorts = [ 80 443 ];
      allowedTCPPorts = [ 80 443 ];
    };
    hostName = "sol";
    networkmanager.enable = true;
  };

  services.unbound.enable = true;

  time.timeZone = "Europe/Amsterdam";

  services.fail2ban.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  environment.shells = with pkgs; [ nushell ];

  systemd.tmpfiles.rules = [
    "d /srv 1777 - - -"
  ];

  virtualisation.hypervGuest.enable = true;

  system.stateVersion = "22.11";
}
