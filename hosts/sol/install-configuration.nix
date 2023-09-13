{ config, pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  boot.loader.grub = {
    enable = true;
    configurationLimit = 8;
    device = "/dev/vda";
  };

  networking = {
    hostName = "sol";
    networkmanager.enable = true;
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

  time.timeZone = "Europe/Amsterdam";

  users.mutableUsers = false;

  users.users.root.hashedPassword = "!";

  users.users.raroh73 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$y$j9T$hFvFXr7PoYmifluLzysxs0$hsK0SKi.cTyh7k8U8JqUX8c3lO9OfSw9mCXAHnSvB5/";
    packages = with pkgs; [
      git
    ];
  };

  system.stateVersion = "22.11";
}
