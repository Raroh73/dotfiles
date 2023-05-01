let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBerp1nA9AU2MUHk8/Fq+OvX0L2PiMqgQh12Zdm0cMyK agenix";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOt72SaSNMlIcwwnmjAp3+oSAc9avEAkFyLdbS9xoShy root@earth";
  mars = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG4n9GZ76/sHCZT9rpmh7UiIEWfcmecmmUEAFIEJKNVR root@mars";
in
{
  "cloudflare-token.age".publicKeys = [ agenix mars ];
  "raroh73-earth-password.age".publicKeys = [ agenix earth ];
  "raroh73-mars-password.age".publicKeys = [ agenix mars ];
}
