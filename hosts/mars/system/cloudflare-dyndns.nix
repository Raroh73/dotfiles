{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-dyndns-token.path;
    domains = [ "nextcloud.raroh73.xyz" "webhook.raroh73.xyz" ];
    proxied = true;
  };
}
