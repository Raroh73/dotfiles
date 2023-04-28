{ config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  networking = {
    firewall.enable = true;
    hostName = "mars";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  users.mutableUsers = false;

  users.users.root.hashedPassword = "!";

  users.users.raroh73 = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$y$j9T$E7B.wD/rB2Z6LnU05C86N1$tREsxNWhOg2Zul8lRrSaUvNX3icaHcV1Ac3QfMRAFXA";
    packages = with pkgs; [
      git
    ];
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  system.stateVersion = "22.11";
}
