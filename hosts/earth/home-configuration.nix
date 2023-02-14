{ pkgs, ... }: {
  imports = [
    ./home/alacritty.nix
    ./home/direnv.nix
    ./home/firefox.nix
    ./home/git.nix
    ./home/gnome.nix
    ./home/helix.nix
    ./home/mangohud.nix
    ./home/nushell.nix
    ./home/ssh.nix
    ./home/starship.nix
    ./home/vscode.nix
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
    podman-compose
    spotify
  ];

  home.stateVersion = "22.11";
}
