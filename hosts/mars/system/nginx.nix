{ lib, pkgs, ... }:
let
  realIpsFromList = lib.strings.concatMapStringsSep "\n" (x: "set_real_ip_from  ${x};");
  fileToList = x: lib.strings.splitString "\n" (builtins.readFile x);
  cfipv4 = fileToList (pkgs.fetchurl {
    url = "https://www.cloudflare.com/ips-v4";
    sha256 = "0ywy9sg7spafi3gm9q5wb59lbiq0swvf0q3iazl0maq1pj1nsb7h";
  });
  cfipv6 = fileToList (pkgs.fetchurl {
    url = "https://www.cloudflare.com/ips-v6";
    sha256 = "1ad09hijignj6zlqvdjxv7rjj8567z357zfavv201b9vx3ikk7cy";
  });
  cloudflare-origin-pull-ca = builtins.fetchurl {
    url = "https://developers.cloudflare.com/ssl/static/authenticated_origin_pull_ca.pem";
    sha256 = "0hxqszqfzsbmgksfm6k0gp0hsx9k1gqx24gakxqv0391wl6fsky1";
  };
in
{
  services.nginx = {
    enable = true;
    commonHttpConfig = ''
      ${realIpsFromList cfipv4}
      ${realIpsFromList cfipv6}
      real_ip_header CF-Connecting-IP;
    '';
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
