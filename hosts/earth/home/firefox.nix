{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
          [ ublock-origin ];
      };
    };
  };
}
