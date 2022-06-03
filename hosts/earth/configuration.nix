{ config, options, pkgs, agenix, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  age = {
    secrets.earth-password.file = ./secrets/earth-password.age;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 100;
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
    extraGroups = [ "wheel" "networkmanager" ];
    passwordFile = config.age.secrets.earth-password.path;
  };

  fonts = {
    fonts = with pkgs; [
      cascadia-code
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

  system.stateVersion = "22.11";
}
