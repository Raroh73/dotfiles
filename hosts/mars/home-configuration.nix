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
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    nushell = {
      enable = true;
      configFile.source =
        let
          default-config = builtins.fetchurl {
            sha256 = "13xlp5sji9zfia0dpwlhirrjkfd498bpj9g3q1f1is9b0my0rj4d";
            url = "https://raw.githubusercontent.com/nushell/nushell/0.83.1/crates/nu-utils/src/sample_config/default_config.nu";
          };
        in
        "${default-config}";
      envFile.source =
        let
          default-env = builtins.fetchurl {
            sha256 = "0qi1g1f32a5l0yp6nb6lizam6033masirfv0hjpd4a5rpp8c8dm1";
            url = "https://raw.githubusercontent.com/nushell/nushell/0.83.1/crates/nu-utils/src/sample_config/default_env.nu";
          };
        in
        "${default-env}";
    };
    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
