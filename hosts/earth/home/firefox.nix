{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
          [ ublock-origin ];
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.urlbar.trimURLs" = false;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "extensions.pocket.enabled" = false;
        };
      };
    };
  };
}
