{ ... }: {
  programs.git = {
    enable = true;
    userName = "Raroh73";
    userEmail = "96078496+Raroh73@users.noreply.github.com";
    extraConfig = {
      apply = {
        whitespace = "fix";
      };
      commit = {
        gpgSign = true;
      };
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
      gpg = {
        format = "ssh";
      };
      pull = {
        ff = "only";
      };
      tag = {
        gpgSign = true;
      };
      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtuv/+9ONhzcSoZRvlmyqtMNtQeFCQfEKfpA/4/dsY/ 96078496+Raroh73@users.noreply.github.com";
      };
    };
  };
}
