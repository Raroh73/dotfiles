{ config, pkgs, ... }: {
  #imports = [ ./disko-configuration.nix ];

  age.secrets.raroh73-earth-password.file = ../../secrets/raroh73-earth-password.age;

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
    };
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
  };

  environment.shells = with pkgs; [ nushell ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/806c8aa2-d22e-4e1b-a688-c0c4da72293b";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/25A2-C505";
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
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
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
    ssh.startAgent = true;
    steam.enable = true;
  };

  security.rtkit.enable = true;

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    fstrim.enable = true;
    fwupd.enable = true;
    ollama.enable = true;
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
      #desktopManager.gnome.enable = true;
      #displayManager.gdm.enable = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
      xkb.layout = "us,pl";
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/e369f49e-b657-4e07-89d8-acdbe6b12b25";
  }];

  system.stateVersion = "23.11";

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
