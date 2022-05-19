{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      matklad.rust-analyzer
      tamasfe.even-better-toml
    ];
    userSettings = {
      "editor.fontFamily" = "Cascadia Code";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.rulers" = [ 80 120 ];
      "extensions.ignoreRecommendations" = true;
      "files.eol" = "\n";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "telemetry.telemetryLevel" = "off";
    };
  };
}
