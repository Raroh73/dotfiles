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
            url = "https://raw.githubusercontent.com/nushell/nushell/0.85.0/crates/nu-utils/src/sample_config/default_config.nu";
            sha256 = "0s2qlqani3yvf9w78paxw855xfmjycza9hnqr4nck2z78fdxld4h";
          };
        in
        "${default-config}";
      envFile.source =
        let
          default-env = builtins.fetchurl {
            url = "https://raw.githubusercontent.com/nushell/nushell/0.85.0/crates/nu-utils/src/sample_config/default_env.nu";
            sha256 = "1bqrk8l7lb4c3q1jzpg4l3jqr4sbabng51sp4ad0gv2rqfgi6n70";
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
