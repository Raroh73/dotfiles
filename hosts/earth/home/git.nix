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
      pull = {
        ff = "only";
      };
      tag = {
        gpgSign = true;
      };
      user = {
        signingKey = "7F60D3C92F885B70";
      };
    };
  };
}
