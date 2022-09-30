let earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFNBr6qhrq+o3VGM+b7Rx//C8t9yroIry9TMriU1nPPx";
in
{
  "earth-password.age".publicKeys = [ earth ];
  "nextdns-config.age".publicKeys = [ earth ];
}
