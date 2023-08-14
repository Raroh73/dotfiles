{ config, pkgs, ... }: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    hostName = "nextcloud.raroh73.xyz";
    https = true;
    config = {
      adminuser = "raroh73";
      adminpassFile = config.age.secrets.nextcloud-adminpass.path;
    };
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit bookmarks calendar contacts news notes tasks;
    };
    logType = "file";
    secretFile = config.age.secrets.nextcloud-secrets.path;
  };
}
