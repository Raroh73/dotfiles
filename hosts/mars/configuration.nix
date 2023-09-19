{ config, lib, pkgs, ... }: {
  age.secrets = {
    backup-mars-environment.file = ../../secrets/backup-mars-environment.age;
    backup-mars-password.file = ../../secrets/backup-mars-password.age;
    backup-mars-repository.file = ../../secrets/backup-mars-repository.age;
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
    raroh73-mars-password.file = ../../secrets/raroh73-mars-password.age;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "cma=256M" ];
    loader = {
      generic-extlinux-compatible = {
        enable = true;
        configurationLimit = 8;
      };
      grub.enable = false;
    };
    tmp.cleanOnBoot = true;
  };

  environment = {
    shells = with pkgs; [ nushell ];
    systemPackages = with pkgs; [ libraspberrypi ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

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
    hostName = "mars";
    networkmanager.enable = true;
  };

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
      experimental-features = [ "flakes" "nix-command" ];
      trusted-users = [ "@wheel" "root" ];
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
    sudo.extraRules = [
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
      };
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit bookmarks calendar contacts news notes tasks;
      };
      extraAppsEnable = true;
      hostName = "nextcloud.raroh73.xyz";
      https = true;
      logType = "file";
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
            useACMEHost = "webhook.raroh73.xyz";
            locations."/" = {
              proxyPass = "http://localhost:9000";
            };
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
    restic.backups.mars = {
      backupCleanupCommand = ''
        rm -fr /var/backups/mars
        nextcloud-occ maintenance:mode --off
      '';
      backupPrepareCommand = ''
        nextcloud-occ maintenance:mode --on
        mkdir -p /var/backups/mars
        ${pkgs.rsync}/bin/rsync -Aavx /var/lib/nextcloud/ /var/backups/mars/nextcloud/
      '';
      environmentFile = config.age.secrets.backup-mars-environment.path;
      initialize = true;
      passwordFile = config.age.secrets.backup-mars-password.path;
      paths = [ "/var/backups/mars" ];
      pruneOpts = [
        "--keep-daily 31"
        "--keep-monthly 12"
        "--keep-yearly 1"
      ];
      repositoryFile = config.age.secrets.backup-mars-repository.path;
    };
    unbound.enable = true;
    webhook = {
      enable = true;
      hooksTemplated = {
        hugo-webhook =
          let
            raroh73_xyz-build = pkgs.writeShellApplication {
              name = "raroh73_xyz-build";
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
              "id": "raroh73_xyz-webhook",
              "execute-command": "${raroh73_xyz-build}/bin/raroh73_xyz-build",
              "trigger-rule": {
                "and": [
                  {
                    "match": {
                      "type": "payload-hmac-sha1",
                      "parameter": {
                        "name": "X-Hub-Signature",
                        "source": "header"
                      },
                      "secret": ""
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

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      nginx.extraGroups = [ "acme" ];
      raroh73 = {
        extraGroups = [ "networkmanager" "wheel" ];
        isNormalUser = true;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+aFhxW7Q8vLMPCS8jPFtqUUePL6Ks9213gsEOJbIOz raroh73@mars" ];
        passwordFile = config.age.secrets.raroh73-mars-password.path;
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };

  zramSwap.enable = true;
}
