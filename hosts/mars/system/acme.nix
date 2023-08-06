{ config, ... }: {
  security.acme = {
    acceptTerms = true;
    certs = {
      "nextcloud.raroh73.xyz" = { };
    };
    defaults = {
      credentialsFile = config.age.secrets.lego-token.path;
      dnsProvider = "cloudflare";
      email = "me@raroh73.xyz";
    };
  };
}
