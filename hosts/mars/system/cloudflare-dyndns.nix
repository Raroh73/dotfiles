{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-token.path;
    domains = [
      "raroh73.xyz"
      "webhook.raroh73.xyz"
      "www.raroh73.xyz"
    ];
    proxied = true;
  };
}
