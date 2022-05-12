{ config, options, pkgs, ... }:

{
  imports = [
    <agenix/modules/age.nix>
    <home-manager/nixos>
    /etc/nixos/hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  
  age = {
    identityPaths = options.age.identityPaths.default ++ [
      /home/raroh73/.ssh/agenix
    ];
    secrets.raroh73-password.file = /etc/nixos/secrets/raroh73-password.age;
  };
  
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      editor = false;
      memtest86.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "earth";
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "pl_PL.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };

  services.xserver = {
    enable = true;
    layout = "pl";
    videoDrivers = [ "nvidia" ];
    displayManager.gdm = {
      enable = true;
      nvidiaWayland = true;
    };
    desktopManager.gnome.enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;  
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.printing.enable = true;
  
  services.fstrim.enable = true;

  users.mutableUsers = false;

  users.users.root.password = "!";

  users.users.raroh73 = {
    isNormalUser = true;
    description = "Raroh73";
    extraGroups = [ "wheel" "networkmanager" ];
    passwordFile = config.age.secrets.raroh73-password.path;
  };

  home-manager.users.raroh73 = { pkgs, ... }: {
    home.packages = [
      (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
      pkgs.bitwarden 
      pkgs.discord 
      pkgs.nixpkgs-fmt 
      pkgs.spotify 
      pkgs.steam
    ];

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
    };

    programs.bash.enable = true;

    programs.firefox = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userName = "Raroh73";
      userEmail = "96078496+Raroh73@users.noreply.github.com";
      signing = {
        key = "7F60D3C92F885B70";
        signByDefault = true;
      };
      extraConfig = {
        apply = {
          whitespace = "fix";
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
        };
        pull = {
          ff = "only";
        };
      };
    };

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          identityFile = "/home/raroh73/.ssh/github";
        };
        "mars" = {
          hostname = "192.168.0.16";
          user = "raroh73";
          identityFile = "/home/raroh73/.ssh/mars";
        };
      };
    };

    programs.vscode = {
      enable = true;
      extensions = [ 
        pkgs.vscode-extensions.esbenp.prettier-vscode 
        pkgs.vscode-extensions.jnoortheen.nix-ide 
        pkgs.vscode-extensions.matklad.rust-analyzer 
        pkgs.vscode-extensions.tamasfe.even-better-toml 
      ];
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.formatOnSave" = true;
        "files.eol" = "\n";
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;
      };
    };
      
    dconf.settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "code.desktop"
          "steam.desktop"
          "discord.desktop"
          "spotify.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
    };
  };

  system = {
    stateVersion = "21.11";
    autoUpgrade = {
      enable = true;
      dates = "daily";
    };
  };
}

