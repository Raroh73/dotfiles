{ config, ... }:
let
  cloudflare-origin-pull-ca = builtins.fetchurl {
    url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
    sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
  };
in
{
  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "${config.services.nextcloud.hostName}" = {
        forceSSL = true;
        useACMEHost = "nextcloud.raroh73.xyz";
        extraConfig = ''
          ssl_client_certificate ${cloudflare-origin-pull-ca};
          ssl_verify_client on;
        '';
      };
    };
  };
}
