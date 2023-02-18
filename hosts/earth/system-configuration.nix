{ config, options, pkgs, ... }: {
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
  };

  networking = {
    hostName = "earth";
    nameservers = [ "193.110.81.0#dns0.eu" "2a0f:fc80::#dns0.eu" "185.253.5.0#dns0.eu" "2a0f:fc81::#dns0.eu" ];
    networkmanager = {
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    extraConfig = "DNSOverTLS=yes";
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

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

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
    extraGroups = [ "networkmanager" "podman" "wheel" ];
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

  hardware.xone.enable = true;

  virtualisation.podman.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8008 ];
  };

  programs.steam.enable = true;

  programs.gamemode.enable = true;

  programs.gnupg.agent.enable = true;

  environment.shells = with pkgs; [ nushell ];

  system.stateVersion = "22.11";
}
