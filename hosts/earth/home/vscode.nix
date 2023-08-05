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
      "css.format.enable" = false;
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
      "html.format.enable" = false;
      "javascript.format.enable" = false;
      "json.format.enable" = false;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.defaultProfile.linux" = "Nushell";
      "terminal.integrated.profiles.linux" = {
        "Nushell" = {
          "path" = "/etc/profiles/per-user/raroh73/bin/nu";
        };
      };
      "typescript.format.enable" = false;
      "window.restoreWindows" = "none";
      "yaml.format.enable" = false;
    };
  };
}
