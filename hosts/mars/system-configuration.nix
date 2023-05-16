{ config, pkgs, ... }: {
  imports = [
    ./system/acme.nix
    ./system/age.nix
    ./system/boot.nix
    ./system/caddy.nix
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
    domains = [ "raroh73.xyz" "www.raroh73.xyz" "miniflux.raroh73.xyz" "webhook.raroh73.xyz" "authelia.raroh73.xyz" "shiori.raroh73.xyz" "lldap.raroh73.xyz" ];
    proxied = true;
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

  services.shiori = {
    enable = true;
    port = 8081;
  };

  hardware.enableRedistributableFirmware = true;

  zramSwap.enable = true;

  environment.shells = with pkgs; [ nushell ];
  environment.systemPackages = with pkgs; [ libraspberrypi ];

  services.authelia.instances.main = {
    enable = true;
    secrets = {
      jwtSecretFile = config.age.secrets.authelia-main-jwt.path;
      oidcHmacSecretFile = config.age.secrets.authelia-main-oidc-hmac.path;
      oidcIssuerPrivateKeyFile = config.age.secrets.authelia-main-oidc-key.path;
      storageEncryptionKeyFile = config.age.secrets.authelia-main-storage.path;
    };
    settingsFiles = [ config.age.secrets.authelia-main-settings.path ];
  };

  services.lldap = {
    enable = true;
    settings = {
      ldap_user_dn = "admin";
      ldap_user_email = "admin@raroh73.xyz";
      ldap_base_dn = "dc=raroh73,dc=xyz";
    };
    environmentFile = config.age.secrets.lldap-environment.path;
  };

  system.stateVersion = "22.11";
}
