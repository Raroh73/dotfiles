{ pkgs, ... }: {
  imports = [
    /etc/nixos/home/firefox.nix
    /etc/nixos/home/git.nix
    /etc/nixos/home/gnome.nix
    /etc/nixos/home/ssh.nix
    /etc/nixos/home/vscode.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.username = "raroh73";
  home.homeDirectory = "/home/raroh73";

  home.packages = [
    (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
    pkgs.bitwarden 
    pkgs.discord 
    pkgs.nixpkgs-fmt 
    pkgs.spotify 
    pkgs.steam
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
  };

  programs.bash.enable = true;
  
  programs.firefox = {
    enable = true;
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  home.stateVersion = "21.11";
}

