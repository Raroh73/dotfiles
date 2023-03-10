{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
          [ ublock-origin ];
        settings = {
          "app.update.auto" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.contentblocking.category" = "strict";
          "browser.shell.checkDefaultBrowser" = false;
          "browser.tabs.firefox-view" = false;
          "browser.urlbar.trimURLs" = false;
          "dom.security.https_only_mode" = true;
          "extensions.pocket.enabled" = false;
        };
      };
    };
  };
}
