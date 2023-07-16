{ config, pkgs, ... }: {
  imports = [
    ./system/acme.nix
    ./system/age.nix
    ./system/authelia.nix
    ./system/boot.nix
    ./system/caddy.nix
    ./system/cloudflare-dyndns.nix
    ./system/restic.nix
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
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedUDPPorts = [ 80 443 ];
      allowedTCPPorts = [ 80 443 ];
    };
    hostName = "mars";
    networkmanager.enable = true;
  };

  services.unbound.enable = true;

  time.timeZone = "Europe/Warsaw";

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

  services.miniflux = {
    enable = true;
    adminCredentialsFile = config.age.secrets.miniflux-admin-credentials.path;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

  environment.shells = with pkgs; [ nushell ];
  environment.systemPackages = with pkgs; [ libraspberrypi ];

  services.lldap = {
    enable = true;
    settings = {
      ldap_base_dn = "dc=raroh73,dc=xyz";
      ldap_user_dn = "admin";
      ldap_user_email = "admin@raroh73.xyz";
    };
    environmentFile = config.age.secrets.lldap-environment.path;
  };

  systemd.watchdog.runtimeTime = "15s";

  system.stateVersion = "22.11";
}
