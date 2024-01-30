{ config, lib, pkgs, ... }: {
  imports = [ ./disko-configuration.nix ];

  age.secrets = {
    backups-nextcloud-environment = {
      file = ../../secrets/backups-nextcloud-environment.age;
      group = "nextcloud";
      owner = "nextcloud";
    };
    backups-nextcloud-password = {
      file = ../../secrets/backups-nextcloud-password.age;
      group = "nextcloud";
      owner = "nextcloud";
    };
    backups-nextcloud-repository = {
      file = ../../secrets/backups-nextcloud-repository.age;
      group = "nextcloud";
      owner = "nextcloud";
    };
    cloudflare-dyndns-token.file = ../../secrets/cloudflare-dyndns-token.age;
    lego-token.file = ../../secrets/lego-token.age;
    nextcloud-adminpass = {
      file = ../../secrets/nextcloud-adminpass.age;
      group = "nextcloud";
      owner = "nextcloud";
    };
    nextcloud-secrets = {
      file = ../../secrets/nextcloud-secrets.age;
      group = "nextcloud";
      owner = "nextcloud";
    };
    raroh73-sirius-password.file = ../../secrets/raroh73-sirius-password.age;
    webhook-environment.file = ../../secrets/webhook-environment.age;
  };

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "sr_mod"
        "usbhid"
        "virtio_pci"
        "virtio_scsi"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
    };
    tmp.cleanOnBoot = true;
  };

  environment.shells = with pkgs; [ nushell ];

  hardware.enableRedistributableFirmware = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.raroh73.imports = [ ./home-configuration.nix ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 80 443 ];
    };
    hostName = "sirius";
    networkmanager.enable = true;
    stevenblack.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    registry.nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "flakes" "nix-command" ];
      keep-derivations = true;
      keep-outputs = true;
    };
  };

  programs.nano = {
    nanorc = ''
      bind ^C copy main
      bind ^F whereis main
      bind ^H replace main
      bind ^Q exit main
      bind ^V paste main
      bind ^X cut main
      bind ^Y redo main
      bind ^Z undo main
      set autoindent
      set constantshow
      set historylog
      set linenumbers
      set minibar
      set nohelp
      set positionlog
      set tabsize 2
      set tabstospaces
      set zap
    '';
    syntaxHighlight = true;
  };

  security = {
    acme = {
      acceptTerms = true;
      certs = {
        "nextcloud.raroh73.xyz" = { };
        "raroh73.xyz" = {
          extraDomainNames = [ "www.raroh73.xyz" ];
        };
        "webhook.raroh73.xyz" = { };
      };
      defaults = {
        credentialsFile = config.age.secrets.lego-token.path;
        dnsProvider = "cloudflare";
        email = "me@raroh73.xyz";
      };
    };
  };

  services = {
    cloudflare-dyndns = {
      enable = true;
      apiTokenFile = config.age.secrets.cloudflare-dyndns-token.path;
      domains = [
        "nextcloud.raroh73.xyz"
        "raroh73.xyz"
        "webhook.raroh73.xyz"
        "www.raroh73.xyz"
      ];
      ipv4 = true;
      proxied = true;
    };
    fail2ban.enable = true;
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      config = {
        adminpassFile = config.age.secrets.nextcloud-adminpass.path;
        adminuser = "raroh73";
        dbtype = "pgsql";
      };
      configureRedis = true;
      database.createLocally = true;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit bookmarks calendar contacts news notes tasks;
      };
      extraAppsEnable = true;
      extraOptions.overwriteProtocol = "https";
      hostName = "nextcloud.raroh73.xyz";
      https = true;
      secretFile = config.age.secrets.nextcloud-secrets.path;
    };
    nginx = {
      enable = true;
      commonHttpConfig =
        let
          realIpsFromList = lib.strings.concatMapStringsSep "\n" (x: "set_real_ip_from  ${x};");
          fileToList = x: lib.strings.splitString "\n" (builtins.readFile x);
          cfipv4 = fileToList (pkgs.fetchurl {
            url = "https://www.cloudflare.com/ips-v4";
            sha256 = "0ywy9sg7spafi3gm9q5wb59lbiq0swvf0q3iazl0maq1pj1nsb7h";
          });
          cfipv6 = fileToList (pkgs.fetchurl {
            url = "https://www.cloudflare.com/ips-v6";
            sha256 = "1ad09hijignj6zlqvdjxv7rjj8567z357zfavv201b9vx3ikk7cy";
          });
        in
        ''
          ${realIpsFromList cfipv4}
          ${realIpsFromList cfipv6}
          real_ip_header CF-Connecting-IP;
        '';
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      virtualHosts =
        let
          cloudflare-origin-pull-ca = builtins.fetchurl {
            url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
            sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
          };
        in
        {
          "nextcloud.raroh73.xyz" = {
            extraConfig = ''
              ssl_client_certificate ${cloudflare-origin-pull-ca};
              ssl_verify_client on;
            '';
            forceSSL = true;
            useACMEHost = "nextcloud.raroh73.xyz";
          };
          "raroh73.xyz" = {
            extraConfig = ''
              ssl_client_certificate ${cloudflare-origin-pull-ca};
              ssl_verify_client on;
              error_page 404 /404.html;
            '';
            forceSSL = true;
            root = "/srv/web/raroh73.xyz/public";
            serverAliases = [ "www.raroh73.xyz" ];
            useACMEHost = "raroh73.xyz";
          };
          "webhook.raroh73.xyz" = {
            extraConfig = ''
              ssl_client_certificate ${cloudflare-origin-pull-ca};
              ssl_verify_client on;
            '';
            forceSSL = true;
            locations."/" = {
              proxyPass = "http://localhost:9000";
            };
            useACMEHost = "webhook.raroh73.xyz";
          };
        };
    };
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    restic.backups.nextcloud = {
      backupCleanupCommand = ''
        ${config.services.nextcloud.occ}/bin/nextcloud-occ maintenance:mode --off
      '';
      backupPrepareCommand = ''
        ${config.services.nextcloud.occ}/bin/nextcloud-occ maintenance:mode --on
        ${config.services.postgresql.package}/bin/pg_dump ${config.services.nextcloud.config.dbname} > /var/lib/nextcloud/database.sql
      '';
      environmentFile = config.age.secrets.backups-nextcloud-environment.path;
      initialize = true;
      passwordFile = config.age.secrets.backups-nextcloud-password.path;
      paths = [ "/var/lib/nextcloud" ];
      pruneOpts = [
        "--keep-daily 31"
        "--keep-monthly 12"
        "--keep-yearly 1"
      ];
      repositoryFile = config.age.secrets.backups-nextcloud-repository.path;
      user = "nextcloud";
    };
    unbound.enable = true;
    webhook = {
      enable = true;
      # anti-pattern
      environment = builtins.readFile config.age.secrets.webhook-environment.path;
      hooksTemplated = {
        website-webhook =
          let
            website-script = pkgs.writeShellApplication {
              name = "website-script";
              runtimeInputs = with pkgs; [ git hugo ];
              text = ''
                rm -fr /srv/web/raroh73.xyz/public
                if [ ! -d /srv/web/raroh73.xyz ]
                then
                  git clone https://github.com/Raroh73/raroh73.xyz.git /srv/web/raroh73.xyz
                  cd /srv/web/raroh73.xyz
                else
                  cd /srv/web/raroh73.xyz
                  git pull https://github.com/Raroh73/raroh73.xyz.git
                fi
                hugo --minify
              '';
            };
          in
          ''
            {
              "id": "website-webhook",
              "execute-command": "${website-script}/bin/website-script",
              "trigger-rule": {
                "and": [
                  {
                    "match": {
                      "type": "payload-hmac-sha1",
                      "parameter": {
                        "name": "X-Hub-Signature",
                        "source": "header"
                      },
                      "secret":  "{{ getenv "SECRET" }}"
                    }
                  },
                  {
                    "match": {
                      "type": "value",
                      "parameter": {
                        "name": "ref",
                        "source": "payload"
                      },
                      "value": "refs/heads/main"
                    }
                  }
                ]
              }
            }
          '';
      };
    };
  };

  system.stateVersion = "22.11";

  systemd = {
    tmpfiles.rules = [
      "d /srv 1777 - - -"
    ];
    watchdog.runtimeTime = "15s";
  };

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      nginx.extraGroups = [ "acme" ];
      raroh73 = {
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPasswordFile = config.age.secrets.raroh73-sirius-password.path;
        isNormalUser = true;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvWwDK5RpM9vqAWfogDFF3o3+scBfBCc5PKUmnR4TTg raroh73@sirius" ];
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
