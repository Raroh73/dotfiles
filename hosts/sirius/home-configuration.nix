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
    git.enable = true;
    nushell = {
      enable = true;
      configFile.source =
        let
          default-config = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.89.0/crates/nu-utils/src/sample_config/default_config.nu";
            sha256 = "0qlhba79mryar4rh7k0s32vvhywqljy1v2z86grhp6p9c9m7ky83";
          };
        in
        "${default-config}";
      envFile.source =
        let
          default-env = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.89.0/crates/nu-utils/src/sample_config/default_env.nu";
            sha256 = "162nzdz7n9kjpl2k02dsv5vrawg7c3f7c4lp6822i93i9kl6k4vr";
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
