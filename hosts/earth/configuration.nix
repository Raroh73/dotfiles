{ config, pkgs, ... }:
{
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

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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
    firewall.enable = true;
    hostName = "earth";
    networkmanager.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    optimise.automatic = true;
    registry.nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      keep-derivations = true;
      keep-outputs = true;
    };
  };

  programs = {
    gamemode.enable = true;
    nix-ld = {
      enable = true;
      libraries = [
        pkgs.alsa-lib
        pkgs.atk
        pkgs.cairo
        pkgs.cups
        pkgs.dbus
        pkgs.expat
        pkgs.fontconfig
        pkgs.gdk-pixbuf
        pkgs.glib
        pkgs.gtk3
        pkgs.libxkbcommon
        pkgs.nspr
        pkgs.nss
        pkgs.pango
        pkgs.vulkan-loader
        pkgs.wayland
        pkgs.xorg.libX11
        pkgs.xorg.libxcb
        pkgs.xorg.libXcomposite
        pkgs.xorg.libXcursor
        pkgs.xorg.libXdamage
        pkgs.xorg.libXext
        pkgs.xorg.libXfixes
        pkgs.xorg.libXi
        pkgs.xorg.libXrandr
        pkgs.xorg.libXrender
        pkgs.xorg.libXScrnSaver
        pkgs.xorg.libXtst
      ];
    };
    ssh.startAgent = true;
    steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
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
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      xkb.layout = "us,pl";
    };
  };

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tomorrow-night.yaml";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/43/wallhaven-43lej9.png";
      hash = "sha256-QY9EnxPoHXlo6J0q1sDdkdC6Jl69RMPnlvOOT3ljqqk=";
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/e369f49e-b657-4e07-89d8-acdbe6b12b25"; } ];

  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        description = "Raroh73";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPasswordFile = config.age.secrets.raroh73-earth-password.path;
        isNormalUser = true;
      };
      root.hashedPassword = "!";
    };
  };
}
