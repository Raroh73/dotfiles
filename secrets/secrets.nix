let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBerp1nA9AU2MUHk8/Fq+OvX0L2PiMqgQh12Zdm0cMyK agenix";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyPTZ02pob767P2qSk0JLIe4AfGMuP0u0MekYUoolud root@earth";
  mars = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINlfc/SQR5rXj1MITk5C8Y5XyJ2ARUfvsoP+gVxZcs3E root@mars";
  sirius = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYwq5b3AcyECOjwnI/C29AiIL3EEGCdg1y0tb6IN0oM root@sirius";
in
{
  "backups-nextcloud-environment.age".publicKeys = [ agenix mars sirius ];
  "backups-nextcloud-password.age".publicKeys = [ agenix mars sirius ];
  "backups-nextcloud-repository.age".publicKeys = [ agenix mars sirius ];
  "cloudflare-dyndns-token.age".publicKeys = [ agenix mars sirius ];
  "lego-token.age".publicKeys = [ agenix mars sirius ];
  "nextcloud-adminpass.age".publicKeys = [ agenix mars sirius ];
  "nextcloud-secrets.age".publicKeys = [ agenix mars sirius ];
  "raroh73-earth-password.age".publicKeys = [ agenix earth ];
  "raroh73-mars-password.age".publicKeys = [ agenix mars ];
  "raroh73-sirius-password.age".publicKeys = [ agenix sirius ];
}
