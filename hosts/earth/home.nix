{ pkgs, nurpkgs, ... }: {
  imports = [
    ../../apps/firefox.nix
    ../../apps/git.nix
    ../../apps/gnome.nix
    ../../apps/nushell.nix
    ../../apps/ssh.nix
    ../../apps/vscode.nix
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
  ];

  programs.gpg.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.stateVersion = "22.11";
}
