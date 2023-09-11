let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBerp1nA9AU2MUHk8/Fq+OvX0L2PiMqgQh12Zdm0cMyK agenix";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOt72SaSNMlIcwwnmjAp3+oSAc9avEAkFyLdbS9xoShy root@earth";
  sol = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdkuTyNPsDKRphXdyOGbSv8f7MUFKiW4zWvTyOYBRCE root@sol";
in
{
  "cloudflare-dyndns-token.age".publicKeys = [ agenix sol ];
  "lego-token.age".publicKeys = [ agenix sol ];
  "nextcloud-adminpass.age".publicKeys = [ agenix sol ];
  "nextcloud-s3-secret.age".publicKeys = [ agenix sol ];
  "nextcloud-secrets.age".publicKeys = [ agenix sol ];
  "raroh73-earth-password.age".publicKeys = [ agenix earth ];
  "raroh73-sol-password.age".publicKeys = [ agenix sol ];
  "restic-sol-environment.age".publicKeys = [ agenix sol ];
  "restic-sol-password.age".publicKeys = [ agenix sol ];
  "restic-sol-repository.age".publicKeys = [ agenix sol ];
}
