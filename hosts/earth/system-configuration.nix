{ pkgs, ... }: {
  imports = [
    ./system/boot.nix
    ./system/fonts.nix
    ./system/users.nix
  ];

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
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

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

  swapDevices = [{
    device = "/dev/disk/by-label/swap";
  }];

  age.secrets = {
    raroh73-earth-password.file = ../../secrets/raroh73-earth-password.age;
  };

  networking = {
    firewall.enable = true;
    hostName = "earth";
    networkmanager.enable = true;
  };

  services.unbound.enable = true;

  time.timeZone = "Europe/Warsaw";

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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

  sound.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.fstrim.enable = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  security.rtkit.enable = true;

  programs.steam.enable = true;

  programs.gamemode.enable = true;

  environment.shells = with pkgs; [ nushell ];

  system.stateVersion = "22.11";
}
