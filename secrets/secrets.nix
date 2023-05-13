let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBerp1nA9AU2MUHk8/Fq+OvX0L2PiMqgQh12Zdm0cMyK agenix";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOt72SaSNMlIcwwnmjAp3+oSAc9avEAkFyLdbS9xoShy root@earth";
  mars = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJC4hkSZTfBsso4IE/r4qXAB0crFSG5mLVZ96jALinn8 root@mars";
in
{
  "authelia-main-jwt.age".publicKeys = [ agenix mars ];
  "authelia-main-oidc-hmac.age".publicKeys = [ agenix mars ];
  "authelia-main-oidc-key.age".publicKeys = [ agenix mars ];
  "authelia-main-settings.age".publicKeys = [ agenix mars ];
  "authelia-main-storage.age".publicKeys = [ agenix mars ];
  "authelia-main-users.age".publicKeys = [ agenix mars ];
  "backup-mars-environment.age".publicKeys = [ agenix mars ];
  "backup-mars-password.age".publicKeys = [ agenix mars ];
  "backup-mars-repository.age".publicKeys = [ agenix mars ];
  "cloudflare-token.age".publicKeys = [ agenix mars ];
  "lego-token.age".publicKeys = [ agenix mars ];
  "miniflux-admin-credentials.age".publicKeys = [ agenix mars ];
  "miniflux-oauth2-id.age".publicKeys = [ agenix mars ];
  "miniflux-oauth2-secret.age".publicKeys = [ agenix mars ];
  "raroh73-earth-password.age".publicKeys = [ agenix earth ];
  "raroh73-mars-password.age".publicKeys = [ agenix mars ];
}
