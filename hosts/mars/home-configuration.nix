_: {
  imports = [
    ./home/bottom.nix
    ./home/git.nix
    ./home/nushell.nix
    ./home/starship.nix
  ];

  home.username = "raroh73";
  home.homeDirectory = "/home/raroh73";

  home.stateVersion = "22.11";
}
