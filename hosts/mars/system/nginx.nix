{ config, ... }: {
  services.nginx.virtualHosts = {
    ${config.services.nextcloud.hostName} = {
      forceSSL = true;
      useACMEHost = "nextcloud.raroh73.xyz";
    };
  };
}
