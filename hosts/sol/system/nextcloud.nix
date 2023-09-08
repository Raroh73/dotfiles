{ config, pkgs, ... }: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "nextcloud.raroh73.xyz";
    https = true;
    config = {
      adminuser = "raroh73";
      adminpassFile = config.age.secrets.nextcloud-adminpass.path;
      objectstore.s3 = {
        enable = true;
        bucket = "sol-nextcloud";
        key = "00341b19355e47f0000000001";
        secretFile = config.age.secrets.nextcloud-s3-secret.path;
        hostname = "s3.eu-central-003.backblazeb2.com";
      };
    };
    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit bookmarks calendar contacts news notes tasks;
    };
    logType = "file";
    secretFile = config.age.secrets.nextcloud-secrets.path;
  };
}
