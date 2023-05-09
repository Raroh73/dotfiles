{ config, pkgs, ... }: {
  users = {
    groups.deploy = { };
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        extraGroups = [ "deploy" "networkmanager" "wheel" ];
        passwordFile = config.age.secrets.raroh73-mars-password.path;
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQi95k0yKYkgnH8r3COiPPyBNqi6pdxyHnGl3qgsshP raroh73@mars" ];
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
