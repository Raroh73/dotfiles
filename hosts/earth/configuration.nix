{ config, pkgs, ... }: {
  age.secrets.raroh73-earth-password.file = ../../secrets/raroh73-earth-password.age;

  boot = {
    binfmt.emulatedSystems = [ "aarch64-linux" ];
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "ehci_pci"
        "firewire_ohci"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        consoleMode = "max";
        editor = false;
      };
    };
    tmp.cleanOnBoot = true;
  };

  environment.shells = with pkgs; [ nushell ];

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

  fonts = {
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" "Noto Emoji" ];
        monospace = [ "Roboto Mono" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      noto-fonts
      noto-fonts-emoji
      roboto
      roboto-mono
      roboto-slab
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
      ];
    };
    pulseaudio.enable = false;
    xone.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.raroh73.imports = [ ./home-configuration.nix ];
  };

  networking = {
    domain = "raroh73.xyz";
    extraHosts = "192.168.0.11 mars.raroh73.xyz";
    firewall.enable = true;
    hostName = "earth";
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
    };
  };

  programs = {
    gamemode.enable = true;
    nano = {
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
    steam.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    fstrim.enable = true;
    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    printing.enable = true;
    unbound.enable = true;
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      videoDrivers = [ "nvidia" ];
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  system.stateVersion = "22.11";

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        description = "Raroh73";
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPasswordFile = config.age.secrets.raroh73-earth-password.path;
        isNormalUser = true;
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
