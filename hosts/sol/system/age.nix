_: {
  age.secrets = {
    cloudflare-dyndns-token.file = ../../../secrets/cloudflare-dyndns-token.age;
    lego-token.file = ../../../secrets/lego-token.age;
    nextcloud-adminpass = {
      file = ../../../secrets/nextcloud-adminpass.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    nextcloud-s3-secret = {
      file = ../../../secrets/nextcloud-s3-secret.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    nextcloud-secrets = {
      file = ../../../secrets/nextcloud-secrets.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    raroh73-sol-password.file = ../../../secrets/raroh73-sol-password.age;
    restic-sol-environment.file = ../../../secrets/restic-sol-environment.age;
    restic-sol-password.file = ../../../secrets/restic-sol-password.age;
    restic-sol-repository.file = ../../../secrets/restic-sol-repository.age;
  };
}
