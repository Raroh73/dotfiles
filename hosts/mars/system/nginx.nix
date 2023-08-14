_:
let
  cloudflare-origin-pull-ca = builtins.fetchurl {
    url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
    sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
  };
in
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "raroh73.xyz" = {
        forceSSL = true;
        useACMEHost = "raroh73.xyz";
        serverAliases = [ "www.raroh73.xyz" ];
        root = "/srv/web/raroh73.xyz/public";
        extraConfig = ''
          ssl_client_certificate ${cloudflare-origin-pull-ca};
          ssl_verify_client on;
          error_page 404 /404.html;
        '';
      };
      "nextcloud.raroh73.xyz" = {
        forceSSL = true;
        useACMEHost = "nextcloud.raroh73.xyz";
        extraConfig = ''
          ssl_client_certificate ${cloudflare-origin-pull-ca};
          ssl_verify_client on;
        '';
      };
      "webhook.raroh73.xyz" = {
        forceSSL = true;
        useACMEHost = "webhook.raroh73.xyz";
        locations."/" = {
          proxyPass = "http://localhost:9000";
        };
        extraConfig = ''
          ssl_client_certificate ${cloudflare-origin-pull-ca};
          ssl_verify_client on;
        '';
      };
    };
  };
}
