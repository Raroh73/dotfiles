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
    sane = {
      enable = true;
      sane.extraBackends = [ pkgs.sane-airscan ];
    };
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
    nix-ld.enable = true;
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
    };
  };

  system.stateVersion = "23.11";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        description = "Raroh73";
        extraGroups = [
          "lp"
          "networkmanager"
          "scanner"
          "wheel"
        ];
        hashedPasswordFile = config.age.secrets.raroh73-earth-password.path;
        isNormalUser = true;
      };
    };
  };
}
