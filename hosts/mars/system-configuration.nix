{ config, pkgs, ... }: {
  imports = [
    ./system/acme.nix
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

  age.secrets = {
    authelia-main-jwt = {
      file = ../../secrets/authelia-main-jwt.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-oidc-hmac = {
      file = ../../secrets/authelia-main-oidc-hmac.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-oidc-key = {
      file = ../../secrets/authelia-main-oidc-key.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-settings = {
      file = ../../secrets/authelia-main-settings.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-storage = {
      file = ../../secrets/authelia-main-storage.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-users = {
      file = ../../secrets/authelia-main-users.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    backup-mars-environment.file = ../../secrets/backup-mars-environment.age;
    backup-mars-password.file = ../../secrets/backup-mars-password.age;
    backup-mars-repository.file = ../../secrets/backup-mars-repository.age;
    cloudflare-token.file = ../../secrets/cloudflare-token.age;
    lego-token.file = ../../secrets/lego-token.age;
    miniflux-admin-credentials.file = ../../secrets/miniflux-admin-credentials.age;
    raroh73-mars-password.file = ../../secrets/raroh73-mars-password.age;
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
    domains = [ "raroh73.xyz" "www.raroh73.xyz" "miniflux.raroh73.xyz" "webhook.raroh73.xyz" "authelia.raroh73.xyz" ];
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

  system.stateVersion = "22.11";
}
