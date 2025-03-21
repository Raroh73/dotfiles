{ pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/mutter" = {
      experimental-features = [ "variable-refresh-rate" ];
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [ ];
      enabled-extensions = [ "auto-move-windows@gnome-shell-extensions.gcampax.github.com" ];
      favorite-apps = [
        "firefox.desktop"
        "steam.desktop"
        "dev.zed.Zed.desktop"
        "code.desktop"
        "discord.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:1"
        "steam.desktop:2"
        "dev.zed.Zed.desktop:3"
        "code.desktop:3"
        "discord.desktop:4"
      ];
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
  };

  home = {
    file = {
      ".continue/config.json".text = builtins.toJSON {
        "models" = [
          {
            "title" = "OLMo";
            "provider" = "ollama";
            "model" = "olmo";
          }
          {
            "title" = "Phi";
            "provider" = "ollama";
            "model" = "phi";
          }
          {
            "title" = "Qwen Coder";
            "provider" = "ollama";
            "model" = "qwen-coder-instruct";
          }
        ];
        "tabAutocompleteModel" = {
          "title" = "Qwen Coder";
          "provider" = "ollama";
          "model" = "qwen-coder-base";
        };
      };
      ".face".source = ../../static/avatar.jpg;
    };
    homeDirectory = "/home/raroh73";
    packages = [
      pkgs.discord
      pkgs.nil
      pkgs.nixd
      pkgs.nixfmt-rfc-style
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
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };
    bottom.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    firefox = {
      enable = true;
      profiles = {
        "Raroh73" = {
          extensions.packages = [ pkgs.nur.repos.rycee.firefox-addons.ublock-origin ];
        };
      };
    };
    git = {
      enable = true;
      extraConfig = {
        apply.whitespace = "fix";
        commit.gpgSign = true;
        core.whitespace = "space-before-tab,trailing-space";
        fetch.prune = true;
        pull.ff = "only";
        tag.gpgSign = true;
      };
      signing = {
        format = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMFheJBiBFv3InmZmINg6TbI5ani8f8s/Fw0C2d5tdHa earth";
        signByDefault = true;
      };
      userEmail = "96078496+Raroh73@users.noreply.github.com";
      userName = "Raroh73";
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };
    mangohud = {
      enable = true;
      settings = {
        full = true;
      };
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "/home/raroh73/.ssh/github";
        };
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    vscode = {
      enable = true;
      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
        extensions = [
          pkgs.vscode-extensions.astro-build.astro-vscode
          pkgs.vscode-extensions.continue.continue
          pkgs.vscode-extensions.davidanson.vscode-markdownlint
          pkgs.vscode-extensions.editorconfig.editorconfig
          pkgs.vscode-extensions.jnoortheen.nix-ide
          pkgs.vscode-extensions.mkhl.direnv
          pkgs.vscode-extensions.streetsidesoftware.code-spell-checker
          pkgs.vscode-extensions.svelte.svelte-vscode
          pkgs.vscode-extensions.redhat.vscode-yaml
          pkgs.vscode-extensions.timonwong.shellcheck
          pkgs.vscode-extensions.yzhang.markdown-all-in-one
        ];
        userSettings = {
          "diffEditor.ignoreTrimWhitespace" = false;
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
    zed-editor = {
      enable = true;
      extensions = [
        "astro"
        "html"
        "nix"
        "svelte"
      ];
      userSettings = {
        "assistant" = {
          "default_model" = {
            "provider" = "ollama";
            "model" = "phi3.5:latest";
          };
          "version" = "2";
        };
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      historySubstringSearch = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
    };
  };
}
