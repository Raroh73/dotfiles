{ config, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        description = "Raroh73";
        extraGroups = [ "networkmanager" "podman" "wheel" ];
        passwordFile = config.age.secrets.raroh73-earth-password.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGK2oF5Zor8L0zXEldXvbHfLYe1XDHOATS6v2yX5PCHK raroh73@earth" ];
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
