_: {
  age.secrets = {
    authelia-main-jwt = {
      file = ../../../secrets/authelia-main-jwt.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-ldap-password = {
      file = ../../../secrets/authelia-main-ldap-password.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-oidc-clients = {
      file = ../../../secrets/authelia-main-oidc-clients.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-oidc-hmac = {
      file = ../../../secrets/authelia-main-oidc-hmac.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-oidc-key = {
      file = ../../../secrets/authelia-main-oidc-key.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    authelia-main-storage = {
      file = ../../../secrets/authelia-main-storage.age;
      owner = "authelia-main";
      group = "authelia-main";
    };
    backup-mars-environment.file = ../../../secrets/backup-mars-environment.age;
    backup-mars-password.file = ../../../secrets/backup-mars-password.age;
    backup-mars-repository.file = ../../../secrets/backup-mars-repository.age;
    cloudflare-token.file = ../../../secrets/cloudflare-token.age;
    lego-token.file = ../../../secrets/lego-token.age;
    lldap-environment.file = ../../../secrets/lldap-environment.age;
    miniflux-admin-credentials.file = ../../../secrets/miniflux-admin-credentials.age;
    raroh73-mars-password.file = ../../../secrets/raroh73-mars-password.age;
  };
}
