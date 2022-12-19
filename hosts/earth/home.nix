{ pkgs, ... }: {
  imports = [
    ../../apps/alacritty.nix
    ../../apps/firefox.nix
    ../../apps/git.nix
    ../../apps/gnome.nix
    ../../apps/helix.nix
    ../../apps/nushell.nix
    ../../apps/ssh.nix
    ../../apps/starship.nix
    ../../apps/vscode.nix
  ];

  home.username = "raroh73";
  home.homeDirectory = "/home/raroh73";
  home.file.face = {
    source = ../../static/avatar.png;
    target = ".face";
  };

  home.packages = with pkgs; [
    bitwarden
    discord
    nixpkgs-fmt
    nordic
    podman-compose
    spotify
  ];

  programs.gpg.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.starship.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.stateVersion = "22.11";
}
