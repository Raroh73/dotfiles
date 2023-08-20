_:
let
  default-config = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/nushell/nushell/0.83.1/crates/nu-utils/src/sample_config/default_config.nu";
    sha256 = "13xlp5sji9zfia0dpwlhirrjkfd498bpj9g3q1f1is9b0my0rj4d";
  };
  default-env = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/nushell/nushell/0.83.1/crates/nu-utils/src/sample_config/default_env.nu";
    sha256 = "0qi1g1f32a5l0yp6nb6lizam6033masirfv0hjpd4a5rpp8c8dm1";
  };
in
{
  programs.nushell = {
    enable = true;
    configFile.source = "${default-config}";
    envFile.source = "${default-env}";
  };
}
