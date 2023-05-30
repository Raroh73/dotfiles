{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-token.path;
    domains = [
      "authelia.raroh73.xyz"
      "lldap.raroh73.xyz"
      "miniflux.raroh73.xyz"
      "raroh73.xyz"
      "webhook.raroh73.xyz"
      "www.raroh73.xyz"
    ];
    proxied = true;
  };
}
