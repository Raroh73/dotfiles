{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      bypass-paywalls-clean
      clearurls
      skip-redirect
      ublock-origin # Filters: https://github.com/yokoffing/Better-Fox/wiki#recommended-filters
    ];
    profiles = {
      "Raroh73" = {
        settings = {
          # Settings taken from https://github.com/yokoffing/Better-Fox
          # License: https://github.com/yokoffing/Better-Fox/blob/master/LICENSE
          # SECTION: FASTFOX
          "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
          "browser.startup.preXulSkeletonUI" = false;
          "browser.startup.homepage.abouthome_cache.enabled" = true;
          # SECTION: SECUREFOX
          # TRACKING PROTECTION
          "browser.contentblocking.category" = "strict";
          "privacy.trackingprotection.lower_network_priority" = true;
          "privacy.partition.network_state.ocsp_cache" = true;
          "privacy.partition.serviceWorkers" = true;
          "beacon.enabled" = false;
          "dom.battery.enabled" = false;
          # OCSP & CERTS / HPKP
          "security.OCSP.enabled" = 0;
          "security.pki.sha1_enforcement_level" = 1;
          "security.cert_pinning.enforcement_level" = 2;
          "security.pki.crlite_mode" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          # SSL / TLS
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "browser.ssl_override_behavior" = 1;
          "security.tls.enable_0rtt_data" = false;
          # DISK AVOIDANCE
          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;
          "browser.shell.shortcutFavicons" = false;
          "browser.pagethumbnails.capturing_disabled" = true;
          "network.cookie.thirdparty.sessionOnly" = true;
          "network.cookie.thirdparty.nonsecureSessionOnly" = true;
          # CLEARING DATA DEFAULTS
          "privacy.cpd.history" = true;
          "privacy.cpd.formdata" = true;
          "privacy.cpd.offlineApps" = true;
          "privacy.cpd.cache" = true;
          "privacy.cpd.cookies" = true;
          "privacy.cpd.sessions" = true;
          "privacy.cpd.siteSettings" = false;
          "privacy.sanitize.timeSpan" = 0;
          "privacy.history.custom" = true;
          # SPECULATIVE CONNECTIONS
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;
          "network.http.speculative-parallel-limit" = 0;
          "network.preload" = false;
          # SEARCH / URL BAR
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.fixup.alternate.enabled" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;
          # HTTPS-FIRST POLICY
          "dom.security.https_first" = true;
          # HTTPS-ONLY MODE
          "dom.security.https_only_mode_pbm" = true;
          "dom.security.https_only_mode_ever_enabled_pbm" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          # DNS-over-HTTPS DOH
          "network.dns.skipTRR-when-parental-control-enabled" = false;
          # PASSWORDS AND AUTOFILL
          "signon.autofillForms.http" = false;
          "security.insecure_field_warning.contextual.enabled" = true;
          "signon.privateBrowsingCapture.enabled" = false;
          "signon.management.page.breach-alerts.enabled" = false;
          "signon.management.page.breachAlertUrl" = "";
          "browser.contentblocking.report.lockwise.enabled" = false;
          "browser.contentblocking.report.lockwise.how_it_works.url" = "";
          "signon.rememberSignons" = false;
          "signon.rememberSignons.visibilityToggle" = false;
          "signon.schemeUpgrades" = false;
          "signon.showAutoCompleteFooter" = false;
          "signon.autologin.proxy" = false;
          "signon.debug" = false;
          "signon.generation.available" = false;
          "signon.generation.enabled" = false;
          "signon.management.page.fileImport.enabled" = false;
          "signon.importedFromSqlite" = false;
          "signon.recipes.path" = "";
          "signon.autofillForms" = false;
          "signon.autofillForms.autocompleteOff" = true;
          "signon.showAutoCompleteOrigins" = false;
          "signon.storeWhenAutocompleteOff" = false;
          "signon.formlessCapture.enabled" = false;
          "extensions.fxmonitor.enabled" = false;
          # ADDRESS + CREDIT CARD MANAGER
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.available" = "off";
          "extensions.formautofill.creditCards.available" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "browser.formfill.enable" = false;
          # MIXED CONTENT + CROSS-SITE
          "network.auth.subresource-http-auth-allow" = 1;
          "security.mixed_content.upgrade_display_content" = true;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "permissions.delegation.enabled" = false;
          # HEADERS / REFERERS
          "network.http.referer.defaultPolicy.trackers" = 1;
          "network.http.referer.defaultPolicy.trackers.pbmode" = 1;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          # GOOGLE SAFE BROWSING
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.safebrowsing.downloads.remote.url" = "";
          # MOZILLA
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.provider.ms-windows-location" = false; # WINDOWS
          "geo.provider.use_corelocation" = false; # MAC
          "geo.provider.use_gpsd" = false; # LINUX
          "browser.region.network.url" = "";
          "browser.region.update.enabled" = false;
          # TELEMETRY
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data: =";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "corroborator.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "default-browser-agent.enabled" = false;
          "extensions.abuseReport.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          # SECTION: PESKYFOX
          # MOZILLA UI
          "layout.css.prefers-color-scheme.content-override" = 2;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          # WARNINGS
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.warnOnCloseOtherTabs" = false;
          "browser.tabs.warnOnOpen" = false;
          "browser.aboutConfig.showWarning" = false;
          # FULLSCREEN
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = -1;
          # NEW TAB PAGE
          "browser.startup.page" = 3;
          "browser.newtabpage.activity-stream.discoverystream.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          # POCKET
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = " ";
          "extensions.pocket.oAuthConsumerKey" = " ";
          "extensions.pocket.site" = " ";
          # DOWNLOADS
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;
          # VARIOUS
          "browser.compactmode.show" = true;
          "browser.menu.showViewImageInfo" = true;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "permissions.default.desktop-notification" = 2;
          "dom.push.enabled" = false;
          "findbar.highlightAll" = true;
          "layout.spellcheckDefault" = 2;
          "accessibility.force_disabled" = 1;
          "browser.bookmarks.max_backups" = 2;
          "browser.display.show_image_placeholders" = false;
          "view_source.wrap_long_lines" = true;
          "devtools.debugger.ui.editor-wrapping" = true;
          "layout.css.constructable-stylesheets.enabled" = true;
          "layout.css.grid-template-masonry-value.enabled" = true;
          # TAB BEHAVIOR
          "dom.disable_window_move_resize" = true;
          "browser.tabs.loadBookmarksInTabs" = true;
          "browser.bookmarks.openInTabClosesMenu" = false;
          "image.jxl.enabled" = true;
          "editor.truncate_user_pastes" = false;
          "media.videocontrols.picture-in-picture.video-toggle.has-used" = true;
          "clipboard.plainTextOnly" = true;
          "dom.popup_allowed_events" = "click dblclick";
        };
      };
    };
  };
}

