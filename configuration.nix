{ config, options, pkgs, ... }: {
  imports = [
    <agenix/modules/age.nix>
    <home-manager/nixos>
    /etc/nixos/hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

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

  security.rtkit.enable = true;

  users.mutableUsers = false;

  users.users.root.password = "!";

  users.users.raroh73 = {
    isNormalUser = true;
    description = "Raroh73";
    extraGroups = [ "wheel" "networkmanager" ];
    passwordFile = config.age.secrets.raroh73-password.path;
  };
  home-manager.users.raroh73 = import /etc/nixos/home/home.nix;

  system = {
    stateVersion = "21.11";
    autoUpgrade = {
      enable = true;
      dates = "daily";
    };
  };
}

