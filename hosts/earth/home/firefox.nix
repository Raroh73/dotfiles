{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons;
          [ ublock-origin ];
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        settings = {
          "app.update.auto" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.contentblocking.category" = "strict";
          "browser.places.speculativeConnect.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.tabs.firefox-view" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.trimURLs" = false;
          "dom.security.https_only_mode" = true;
          "extensions.pocket.enabled" = false;
          "network.dns.disablePrefetch" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.IDN_show_punycode" = true;
          "network.predictor.enable-prefetch" = false;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;
          "network.trr.mode" = 5;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.rememberSignons" = false;
        };
      };
    };
  };
}
