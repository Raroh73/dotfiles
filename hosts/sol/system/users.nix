{ config, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users = {
      nginx.extraGroups = [ "acme" ];
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        passwordFile = config.age.secrets.raroh73-sol-password.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINfREsJT905qQdSfEDgZehBmFpwr5229vwrfS2MDfO/R raroh73@sol" ];
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
