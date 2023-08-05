{ config, ... }: {
  security.acme = {
    acceptTerms = true;
    certs = { };
    defaults = {
      credentialsFile = config.age.secrets.lego-token.path;
      dnsProvider = "cloudflare";
      email = "me@raroh73.xyz";
    };
  };
}
