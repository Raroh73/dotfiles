{ config, ... }: {
  services.authelia.instances.main = {
    enable = true;
    secrets = {
      jwtSecretFile = config.age.secrets.authelia-main-jwt.path;
      oidcHmacSecretFile = config.age.secrets.authelia-main-oidc-hmac.path;
      oidcIssuerPrivateKeyFile = config.age.secrets.authelia-main-oidc-key.path;
      storageEncryptionKeyFile = config.age.secrets.authelia-main-storage.path;
    };
    settingsFiles = [ config.age.secrets.authelia-main-settings.path ];
  };
}
