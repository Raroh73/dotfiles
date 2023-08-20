{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      davidanson.vscode-markdownlint
      esbenp.prettier-vscode
      jnoortheen.nix-ide
      matklad.rust-analyzer
      mkhl.direnv
      redhat.vscode-yaml
      tamasfe.even-better-toml
      timonwong.shellcheck
    ];
    mutableExtensionsDir = false;
    userSettings = {
      "[css][javascript][json][typescript][yaml]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "vscode.html-language-features";
      };
      "editor.fontFamily" = "CaskaydiaCove Nerd Font";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.linkedEditing" = true;
      "editor.rulers" = [ 80 120 ];
      "files.eol" = "\n";
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;
      "files.trimTrailingWhitespace" = true;
      "git.autofetch" = true;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.defaultProfile.linux" = "Nushell";
      "terminal.integrated.profiles.linux" = {
        "Nushell" = {
          "path" = "/etc/profiles/per-user/raroh73/bin/nu";
        };
      };
      "window.restoreWindows" = "none";
    };
  };
}
