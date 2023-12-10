{ lib, pkgs, ... }: {
  dconf.settings = {
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      document-font-name = "Noto Sans 11";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Noto Sans 11";
      gtk-theme = "Adwaita-dark";
      monospace-font-name = "Noto Sans Mono 11";
    };
    "org/gnome/desktop/wm/preferences" = {
      theme = "Adwaita";
      titlebar-font = "Noto Sans Bold 11";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    "org/gnome/shell" = {
      disabled-extensions = [ ];
      enabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "chromium-browser.desktop"
        "steam.desktop"
        "code.desktop"
        "Alacritty.desktop"
        "element-desktop.desktop"
        "discord.desktop"
        "spotify.desktop"
        "bitwarden.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:1"
        "chromium-browser.desktop:1"
        "steam.desktop:2"
        "code.desktop:3"
      ];
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
  };

  home = {
    file.face = {
      source = ../../static/avatar.png;
      target = ".face";
    };
    homeDirectory = "/home/raroh73";
    packages = with pkgs; [
      bitwarden
      calibre
      discord
      element-desktop
      libreoffice
      nextcloud-client
      nixpkgs-fmt
      spotify
    ];
    stateVersion = "22.11";
    username = "raroh73";
  };

  programs = {
    alacritty.enable = true;
    atuin = {
      enable = true;
      enableNushellIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };
    bat.enable = true;
    bottom.enable = true;
    broot = {
      enable = true;
      enableNushellIntegration = true;
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    chromium = {
      enable = true;
      extensions = [{
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }];
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    firefox = {
      enable = true;
      profiles = {
        "Raroh73" = {
          extensions = with pkgs.nur.repos.rycee.firefox-addons;
            [ ublock-origin ];
          search = {
            default = "DuckDuckGo";
            force = true;
          };
          settings = {
            "app.update.auto" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.contentblocking.category" = "strict";
            "browser.places.speculativeConnect.enabled" = false;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.tabs.firefox-view" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.urlbar.trimURLs" = false;
            "dom.security.https_only_mode" = true;
            "extensions.pocket.enabled" = false;
            "network.dns.disablePrefetch" = true;
            "network.http.speculative-parallel-limit" = 0;
            "network.IDN_show_punycode" = true;
            "network.predictor.enable-prefetch" = false;
            "network.predictor.enabled" = false;
            "network.prefetch-next" = false;
            "network.trr.mode" = 5;
            "signon.autofillForms" = false;
            "signon.formlessCapture.enabled" = false;
            "signon.rememberSignons" = false;
          };
        };
      };
    };
    git = {
      enable = true;
      extraConfig = {
        apply = {
          whitespace = "fix";
        };
        commit = {
          gpgSign = true;
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
        };
        fetch = {
          prune = true;
        };
        gpg = {
          format = "ssh";
        };
        pull = {
          ff = "only";
        };
        tag = {
          gpgSign = true;
        };
        user = {
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtuv/+9ONhzcSoZRvlmyqtMNtQeFCQfEKfpA/4/dsY/ 96078496+Raroh73@users.noreply.github.com";
        };
      };
      userName = "Raroh73";
      userEmail = "96078496+Raroh73@users.noreply.github.com";
    };
    mangohud = {
      enable = true;
      settings = {
        full = true;
      };
    };
    nushell = {
      enable = true;
      configFile.source =
        let
          default-config = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.86.0/crates/nu-utils/src/sample_config/default_config.nu";
            sha256 = "1pwxx79v5597cbf80kr8gfz1hkfnnffqq95vlvibsb7p309x468w";
          };
        in
        "${default-config}";
      envFile.source =
        let
          default-env = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.86.0/crates/nu-utils/src/sample_config/default_env.nu";
            sha256 = "122jb77r0kbgpzsigq04ysa9ydicxmpba0551ps7fwrzlyg9r0px";
          };
        in
        "${default-env}";
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "/home/raroh73/.ssh/github";
        };
        "raroh73.mars.raroh73.xyz" = {
          hostname = "mars.raroh73.xyz";
          identityFile = "/home/raroh73/.ssh/mars";
          user = "raroh73";
        };
        "root.mars.raroh73.xyz" = {
          hostname = "mars.raroh73.xyz";
          identityFile = "/home/raroh73/.ssh/root";
          user = "root";
        };
      };
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        davidanson.vscode-markdownlint
        esbenp.prettier-vscode
        jnoortheen.nix-ide
        matklad.rust-analyzer
        mkhl.direnv
        redhat.vscode-yaml
        tamasfe.even-better-toml
        timonwong.shellcheck
      ];
      mutableExtensionsDir = false;
      userSettings = {
        "[css][html][javascript][json][typescript][yaml]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "editor.fontFamily" = "CaskaydiaCove Nerd Font";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "editor.rulers" = [ 80 120 ];
        "files.eol" = "\n";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;
        "git.autofetch" = true;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.defaultProfile.linux" = "Nushell";
        "terminal.integrated.profiles.linux" = {
          "Nushell" = {
            "path" = "/etc/profiles/per-user/raroh73/bin/nu";
          };
        };
        "window.restoreWindows" = "none";
      };
    };
  };
}
