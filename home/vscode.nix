{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.matklad.rust-analyzer
      pkgs.vscode-extensions.tamasfe.even-better-toml
    ];
    userSettings = {
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
