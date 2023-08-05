{ config, ... }: {
  services.cloudflare-dyndns = {
    enable = true;
    apiTokenFile = config.age.secrets.cloudflare-dyndns-token.path;
    domains = [ ];
    proxied = true;
  };
}
