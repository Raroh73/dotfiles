let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKFbAvMUTB35UhAvTWVhKxEx3piB2R6BPk/d+g204ghH agenix";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyPTZ02pob767P2qSk0JLIe4AfGMuP0u0MekYUoolud root@earth";
in
{
  "raroh73-earth-password.age".publicKeys = [
    agenix
    earth
  ];
}
