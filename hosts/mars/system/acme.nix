{ config, ... }: {
  security.acme = {
    acceptTerms = true;
    certs = {
      "authelia.raroh73.xyz" = { };
      "lldap.raroh73.xyz" = { };
      "miniflux.raroh73.xyz" = { };
      "raroh73.xyz" = {
        extraDomainNames = [ "www.raroh73.xyz" ];
      };
      "shiori.raroh73.xyz" = { };
      "webhook.raroh73.xyz" = { };
    };
    defaults = {
      credentialsFile = config.age.secrets.lego-token.path;
      dnsProvider = "cloudflare";
      email = "me@raroh73.xyz";
    };
  };
}
