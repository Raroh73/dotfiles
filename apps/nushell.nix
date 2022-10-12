{ ... }: {
  programs.nushell = {
    enable = true;
    configFile = {
      text = "";
    };
    envFile.source = ./env.nu;
  };
}
