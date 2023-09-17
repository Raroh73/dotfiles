{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    firewall.enable = true;
    hostName = "earth";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    videoDrivers = [ "nvidia" ];

  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        hashedPassword = "$6$x1KjgZ.8XadJt7ka$GI96zpDV6MeO9XYKxvC0VPb.oMh5wGrKSOxgStbSQ9Lsid.j2AUHmxn7JsKnN5puh251kgGIXmnxKgBDfuPMA1";
        packages = with pkgs; [
          git
        ];
      };
      root.hashedPassword = "!";
    };
  };

  system.stateVersion = "22.11";
}
