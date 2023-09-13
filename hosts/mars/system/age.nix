_: {
  age.secrets = {
    backup-mars-environment.file = ../../../secrets/backup-mars-environment.age;
    backup-mars-password.file = ../../../secrets/backup-mars-password.age;
    backup-mars-repository.file = ../../../secrets/backup-mars-repository.age;
    cloudflare-dyndns-token.file = ../../../secrets/cloudflare-dyndns-token.age;
    lego-token.file = ../../../secrets/lego-token.age;
    nextcloud-adminpass = {
      file = ../../../secrets/nextcloud-adminpass.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    nextcloud-secrets = {
      file = ../../../secrets/nextcloud-secrets.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    raroh73-mars-password.file = ../../../secrets/raroh73-mars-password.age;
  };
}
