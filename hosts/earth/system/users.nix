{ config, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users = {
      raroh73 = {
        isNormalUser = true;
        description = "Raroh73";
        extraGroups = [ "networkmanager" "podman" "wheel" ];
        passwordFile = config.age.secrets.raroh73-earth-password.path;
        shell = pkgs.nushell;
      };
      root.hashedPassword = "!";
    };
  };
}
