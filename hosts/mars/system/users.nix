{ config, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users = {
      nginx.extraGroups = [ "acme" ];
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        passwordFile = config.age.secrets.raroh73-sol-password.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+aFhxW7Q8vLMPCS8jPFtqUUePL6Ks9213gsEOJbIOz raroh73@mars" ];
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
