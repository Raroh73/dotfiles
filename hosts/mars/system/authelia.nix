{ config, ... }: {
  services.authelia.instances.main = {
    enable = true;
    environmentVariables = {
      AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE = config.age.secrets.authelia-main-ldap-password.path;
    };
    secrets = {
      jwtSecretFile = config.age.secrets.authelia-main-jwt.path;
      oidcHmacSecretFile = config.age.secrets.authelia-main-oidc-hmac.path;
      oidcIssuerPrivateKeyFile = config.age.secrets.authelia-main-oidc-key.path;
      storageEncryptionKeyFile = config.age.secrets.authelia-main-storage.path;
    };
    settings = {
      theme = "auto";
      authentication_backend = {
        password_reset.disable = false;
        refresh_interval = "1m";
        ldap = {
          implementation = "custom";
          url = "ldap://localhost:3890";
          timeout = "5s";
          start_tls = false;
          base_dn = "dc=raroh73,dc=xyz";
          username_attribute = "uid";
          additional_users_dn = "ou=people";
          users_filter = "(&({username_attribute}={input})(objectClass=person))";
          additional_groups_dn = "ou=groups";
          groups_filter = "(member={dn})";
          group_name_attribute = "cn";
          mail_attribute = "mail";
          display_name_attribute = "displayName";
          user = "uid=admin,ou=people,dc=raroh73,dc=xyz";
        };
      };
      access_control.default_policy = "two_factor";
      session.domain = "authelia.raroh73.xyz";
      storage.local.path = "/var/lib/authelia-main/db.sqlite3";
      notifier.filesystem.filename = "/var/lib/authelia-main/notification.txt";
    };
    settingsFiles = [ config.age.secrets.authelia-main-oidc-clients.path ];
  };
}
