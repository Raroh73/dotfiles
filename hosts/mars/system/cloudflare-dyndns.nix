{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-dyndns-token.path;
    domains = [
      "raroh73.xyz"
      "nextcloud.raroh73.xyz"
      "webhook.raroh73.xyz"
      "www.raroh73.xyz"
    ];
    ipv4 = true;
    proxied = true;
  };
}
