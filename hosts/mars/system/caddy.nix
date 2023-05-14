_: {
  services.caddy = {
    enable = true;
    virtualHosts = {
      "raroh73.xyz" = {
        serverAliases = [ "www.raroh73.xyz" ];
        useACMEHost = "raroh73.xyz";
        extraConfig = ''
          root * /srv/web/raroh73.xyz/public
          file_server
        '';
      };
      "miniflux.raroh73.xyz" = {
        useACMEHost = "miniflux.raroh73.xyz";
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
      "webhook.raroh73.xyz" = {
        useACMEHost = "webhook.raroh73.xyz";
        extraConfig = ''
          reverse_proxy localhost:9000
        '';
      };
      "authelia.raroh73.xyz" = {
        useACMEHost = "authelia.raroh73.xyz";
        extraConfig = ''
          reverse_proxy localhost:9091
        '';
      };
    };
  };
}
