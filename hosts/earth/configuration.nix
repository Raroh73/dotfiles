{ config, options, pkgs, agenix, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  age.secrets = {
    earth-password.file = ../../secrets/earth-password.age;
    nextdns-config.file = ../../secrets/nextdns-config.age;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 16;
      consoleMode = "max";
      editor = false;
      memtest86.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "earth";
    nameservers = [ "127.0.0.1" "::1" ];
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  services.nextdns = {
    enable = true;
    arguments = [ "-config-file" config.age.secrets.nextdns-config.path ];
  };

  time.timeZone = "Europe/Warsaw";

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  sound.enable = false;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  services.fstrim.enable = true;

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        path = "/etc/ssh/earth";
        type = "ed25519";
      }
    ];
  };

  security.rtkit.enable = true;

  users.mutableUsers = false;

  users.users.root.hashedPassword = "!";

  users.users.raroh73 = {
    isNormalUser = true;
    description = "Raroh73";
    extraGroups = [ "networkmanager" "wheel" ];
    passwordFile = config.age.secrets.earth-password.path;
    shell = pkgs.nushell;
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      noto-fonts
      noto-fonts-emoji
      roboto
      roboto-mono
      roboto-slab
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" "Noto Emoji" ];
        monospace = [ "Roboto Mono" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };
  };

  environment.shells = with pkgs; [ nushell ];

  system.stateVersion = "22.11";
}
