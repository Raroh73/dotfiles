{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      davidanson.vscode-markdownlint
      jnoortheen.nix-ide
      matklad.rust-analyzer
      mkhl.direnv
      redhat.vscode-yaml
      tamasfe.even-better-toml
      timonwong.shellcheck
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "editor.fontFamily" = "CaskaydiaCove Nerd Font";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.rulers" = [ 80 120 ];
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = true;
      "files.eol" = "\n";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.defaultProfile.linux" = "Nushell";
      "terminal.integrated.profiles.linux" = {
        "Nushell" = {
          "path" = "/etc/profiles/per-user/raroh73/bin/nu";
        };
      };
      "update.mode" = "none";
    };
  };
}
