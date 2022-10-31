{ ... }: {
  programs.nushell = {
    enable = true;
    configFile.text = ''
      let-env config = {
        hooks: {
          pre_prompt: [{
            code: "
              let direnv = (direnv export json | from json)
              let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
              $direnv | load-env
            "
          }]
        }
      }

      source ~/.cache/starship/init.nu
    '';
    envFile.text = ''
      mkdir ~/.cache/starship
      starship init nu | save ~/.cache/starship/init.nu
    '';
  };
}
