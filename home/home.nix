{ pkgs, ... }: {
  imports = [
    /etc/nixos/home/bash.nix
    /etc/nixos/home/firefox.nix
    /etc/nixos/home/git.nix
    /etc/nixos/home/gnome.nix
    /etc/nixos/home/ssh.nix
    /etc/nixos/home/vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import <nur> {
      inherit pkgs;
    };
  };

  home.username = "raroh73";
  home.homeDirectory = "/home/raroh73";

  home.packages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> { })
    pkgs.bitwarden
    pkgs.discord
    pkgs.nixpkgs-fmt
    pkgs.spotify
    pkgs.steam
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.stateVersion = "21.11";
}
