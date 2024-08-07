{ config, pkgs, ... }:
{
  #imports = [ ./disko-configuration.nix ];

  age.secrets.raroh73-earth-password.file = ../../secrets/raroh73-earth-password.age;

  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
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
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
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
    optimise.automatic = true;
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
    ollama = {
      enable = true;
      rocmOverrideGfx = "10.3.0";
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
      xkb.layout = "us,pl";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tomorrow-night.yaml";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/43/wallhaven-43lej9.png";
      hash = "sha256-QY9EnxPoHXlo6J0q1sDdkdC6Jl69RMPnlvOOT3ljqqk=";
    };
    polarity = "dark";
  };

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
