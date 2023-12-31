{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    #"${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
    #./disko-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "earth";
    networkmanager.enable = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    settings.experimental-features = [ "flakes" "nix-command" ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.git.enable = true;

  services = {
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

  system.stateVersion = "23.11";

  time.timeZone = "Europe/Warsaw";

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        description = "Raroh73";
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$y$j9T$G0rX4W6eqrwz2gNOSuM9/1$M1SiWyYp.Xq4u0GPAJxZYeW0CJ6q3BzIJ2ubkgi6DP3";
        isNormalUser = true;
      };
      root.hashedPassword = "!";
    };
  };
}
