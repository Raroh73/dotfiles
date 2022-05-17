{ ... }: {
  programs.git = {
    enable = true;
    userName = "Raroh73";
    userEmail = "96078496+Raroh73@users.noreply.github.com";
    signing = {
      key = "7F60D3C92F885B70";
      signByDefault = true;
    };
    extraConfig = {
      apply = {
        whitespace = "fix";
      };
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
      pull = {
        ff = "only";
      };
    };
  };
}
