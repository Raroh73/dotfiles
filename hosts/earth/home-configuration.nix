{ pkgs, ... }:
{
  #dconf.settings = {
  #  "org/gnome/desktop/datetime" = {
  #    automatic-timezone = true;
  #  };
  #  "org/gnome/desktop/interface" = {
  #    color-scheme = "prefer-dark";
  #    document-font-name = "Noto Sans 11";
  #    font-antialiasing = "rgba";
  #    font-hinting = "slight";
  #    font-name = "Noto Sans 11";
  #    gtk-theme = "Adwaita-dark";
  #    monospace-font-name = "Noto Sans Mono 11";
  #  };
  #  "org/gnome/desktop/wm/preferences" = {
  #    theme = "Adwaita";
  #    titlebar-font = "Noto Sans Bold 11";
  #  };
  #  "org/gnome/settings-daemon/plugins/color" = {
  #    night-light-enabled = true;
  #    night-light-schedule-automatic = true;
  #  };
  #  "org/gnome/shell" = {
  #    disabled-extensions = [ ];
  #    enabled-extensions = [
  #      "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
  #    ];
  #    favorite-apps = [
  #      "firefox.desktop"
  #      "chromium-browser.desktop"
  #      "steam.desktop"
  #      "code.desktop"
  #      "Alacritty.desktop"
  #      "element-desktop.desktop"
  #      "discord.desktop"
  #      "spotify.desktop"
  #      "bitwarden.desktop"
  #      "org.gnome.Nautilus.desktop"
  #    ];
  #  };
  #  "org/gnome/shell/extensions/auto-move-windows" = {
  #    application-list = [
  #      "firefox.desktop:1"
  #      "chromium-browser.desktop:1"
  #      "steam.desktop:2"
  #      "code.desktop:3"
  #    ];
  #  };
  #  "org/gnome/system/location" = {
  #    enabled = true;
  #  };
  #};

  home = {
    file.face = {
      source = ../../static/avatar.jpg;
      target = ".face";
    };
    homeDirectory = "/home/raroh73";
    packages = [
      pkgs.bitwarden
      pkgs.discord
      pkgs.element-desktop
      pkgs.handbrake
      pkgs.nil
      pkgs.nixfmt-rfc-style
      pkgs.spotify
    ];
    stateVersion = "23.11";
    username = "raroh73";
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

  programs = {
    atuin = {
      enable = true;
      enableBashIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };
    bash.enable = true;
    bottom.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    firefox = {
      enable = true;
      profiles = {
        "Raroh73" = {
          extensions = [
            pkgs.nur.repos.rycee.firefox-addons.proton-pass
            pkgs.nur.repos.rycee.firefox-addons.ublock-origin
          ];
        };
      };
    };
    git = {
      enable = true;
      extraConfig = {
        apply.whitespace = "fix";
        commit.gpgSign = true;
        core.whitespace = "trailing-space,space-before-tab";
        fetch.prune = true;
        gpg.format = "ssh";
        pull.ff = "only";
        tag.gpgSign = true;
        user = {
          #signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtuv/+9ONhzcSoZRvlmyqtMNtQeFCQfEKfpA/4/dsY/ 96078496+Raroh73@users.noreply.github.com";
          signingKey = "~/.ssh/github.pub";
        };
      };
      userName = "Raroh73";
      userEmail = "96078496+Raroh73@users.noreply.github.com";
    };
    mangohud = {
      enable = true;
      settings = {
        fps_limit = 120;
        full = true;
        vsync = 0;
      };
    };
    mpv = {
      enable = true;
      config = {
        hwdec = "auto";
      };
    };
    readline = {
      enable = true;
      bindings = {
        "\\e[A" = "history-search-backward";
        "\\e[B" = "history-search-forward";
      };
      variables = {
        completion-ignore-case = true;
        show-all-if-ambiguous = true;
      };
    };
    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "/home/raroh73/.ssh/github";
        };
      };
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = [
        pkgs.vscode-extensions.continue.continue
        pkgs.vscode-extensions.davidanson.vscode-markdownlint
        pkgs.vscode-extensions.editorconfig.editorconfig
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.mkhl.direnv
        pkgs.vscode-extensions.streetsidesoftware.code-spell-checker
        pkgs.vscode-extensions.redhat.vscode-yaml
        pkgs.vscode-extensions.tamasfe.even-better-toml
        pkgs.vscode-extensions.timonwong.shellcheck
        pkgs.vscode-extensions.yzhang.markdown-all-in-one
      ];
      mutableExtensionsDir = false;
      userSettings = {
        "editor.fontFamily" = "CaskaydiaCove Nerd Font";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.linkedEditing" = true;
        "editor.rulers" = [
          80
          120
        ];
        "files.eol" = "\n";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;
        "git.autofetch" = true;
        "git.pruneOnFetch" = true;
        "git.useIntegratedAskPass" = false;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
        "telemetry.telemetryLevel" = "off";
        "window.restoreWindows" = "none";
      };
    };
  };
}
