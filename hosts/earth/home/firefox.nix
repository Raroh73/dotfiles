{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = { };
    };
  };
}
