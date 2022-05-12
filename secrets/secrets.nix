let key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPAJh+wMRLRHsNXoB5oS+cG5Bn5chyIWNFm49SHa6RUG agenix";
in {
  "raroh73-password.age".publicKeys = [ key ];
}
