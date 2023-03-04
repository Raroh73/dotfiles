let
  agenix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBerp1nA9AU2MUHk8/Fq+OvX0L2PiMqgQh12Zdm0cMyK";
  earth = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOt72SaSNMlIcwwnmjAp3+oSAc9avEAkFyLdbS9xoShy";
in
{
  "raroh73-earth-password.age".publicKeys = [ agenix earth ];
}
