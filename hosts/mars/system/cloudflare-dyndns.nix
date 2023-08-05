{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-token.path;
    domains = [
      "miniflux.raroh73.xyz"
      "raroh73.xyz"
      "webhook.raroh73.xyz"
      "www.raroh73.xyz"
    ];
    proxied = true;
  };
}
