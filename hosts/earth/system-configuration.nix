{ options, pkgs, ... }: {
  imports = [
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
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  age.secrets = {
    raroh73-earth-password.file = ../../secrets/raroh73-earth-password.age;
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8008 ];
    };
    hostName = "earth";
    nameservers = [ "193.110.81.0#dns0.eu" "2a0f:fc80::#dns0.eu" "185.253.5.0#dns0.eu" "2a0f:fc81::#dns0.eu" ];
    networkmanager.enable = true;
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
    openFirewall = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  security.rtkit.enable = true;

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

  virtualisation.podman.enable = true;

  programs.steam.enable = true;

  programs.gamemode.enable = true;

  environment.shells = with pkgs; [ nushell ];

  system.stateVersion = "22.11";
}
