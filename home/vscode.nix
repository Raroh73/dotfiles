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
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.formatOnSave" = true;
      "files.eol" = "\n";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;
    };
  };
}

