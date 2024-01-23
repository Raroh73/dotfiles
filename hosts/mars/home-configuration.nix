_: {
  home = {
    homeDirectory = "/home/raroh73";
    stateVersion = "22.11";
    username = "raroh73";
  };

  programs = {
    atuin = {
      enable = true;
      enableNushellIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };
    bat.enable = true;
    bottom.enable = true;
    broot = {
      enable = true;
      enableNushellIntegration = true;
    };
    nushell = {
      enable = true;
      configFile.source =
        let
          default-config = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.86.0/crates/nu-utils/src/sample_config/default_config.nu";
            sha256 = "1pwxx79v5597cbf80kr8gfz1hkfnnffqq95vlvibsb7p309x468w";
          };
        in
        "${default-config}";
      envFile.source =
        let
          default-env = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.86.0/crates/nu-utils/src/sample_config/default_env.nu";
            sha256 = "122jb77r0kbgpzsigq04ysa9ydicxmpba0551ps7fwrzlyg9r0px";
          };
        in
        "${default-env}";
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
