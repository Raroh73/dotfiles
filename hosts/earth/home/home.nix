{ pkgs, nurpkgs, ... }: {
  imports = [
    ./firefox.nix
    ./git.nix
    ./gnome.nix
    ./nushell.nix
    ./ssh.nix
    ./vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ nurpkgs.overlay ];

  home.username = "raroh73";
  home.homeDirectory = "/home/raroh73";

  home.packages = with pkgs; [
    bitwarden
    discord
    nixpkgs-fmt
    spotify
    steam
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.stateVersion = "22.11";
}
