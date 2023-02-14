{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles = {
      "Raroh73" = {
        settings = {
          # Settings taken from https://github.com/yokoffing/Betterfox
          # License: https://github.com/yokoffing/Betterfox/blob/master/LICENSE
          # SECTION: FASTFOX
          "image.jxl.enabled" = true;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "gfx.offscreencanvas.enabled" = true;
          "layout.css.font-loading-api.workers.enabled" = true;
          "layout.css.animation-composition.enabled" = true;
          "dom.importMaps.enabled" = true;
          # SECTION: SECUREFOX
          # TRACKING PROTECTION
          "browser.contentblocking.category" = "strict";
          "privacy.trackingprotection.emailtracking.enabled" = true;
          "privacy.query_stripping.strip_list" = "__hsfp __hssc __hstc __s _hsenc _openstat dclid fbclid gbraid gclid hsCtaTracking igshid mc_eid ml_subscriber ml_subscriber_hash msclkid oft_c oft_ck oft_d oft_id oft_ids oft_k oft_lk oft_sk oly_anon_id oly_enc_id rb_clickid s_cid twclid vero_conv vero_id wbraid wickedid yclid";
          "urlclassifier.trackingSkipURLs" = "*.reddit.com = *.twitter.com = *.twimg.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com = *.twitter.com = *.twimg.com";
          "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
          "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;
          "beacon.enabled" = false;
          # OCSP & CERTS / HPKP
          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "security.cert_pinning.enforcement_level" = 2;
          # SSL / TLS
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;
          # FONTS
          "layout.css.font-visibility.private" = 1;
          "layout.css.font-visibility.trackingprotection" = 1;
          # DISK AVOIDANCE
          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;
          "browser.pagethumbnails.capturing_disabled" = true;
          # SHUTDOWN & SANITIZING
          "privacy.history.custom" = true;
          # SPECULATIVE CONNECTIONS
          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          # SEARCH / URL BAR
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "network.IDN_show_punycode" = true;
          # HTTPS-ONLY MODE
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_error_page_user_suggestions" = true;
          # DNS-over-HTTPS (DOH)
          "network.dns.skipTRR-when-parental-control-enabled" = false;
          # PROXY / SOCKS / IPv6
          "network.proxy.socks_remote_dns" = true;
          "network.file.disable_unc_paths" = true;
          "network.gio.supported-protocols" = "";
          # PASSWORDS AND AUTOFILL
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;
          "editor.truncate_user_pastes" = false;
          "layout.forms.reveal-password-button.enabled" = true;
          # ADDRESS + CREDIT CARD MANAGER
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.heuristics.enabled" = false;
          "browser.formfill.enable" = false;
          # MIXED CONTENT + CROSS-SITE
          "network.auth.subresource-http-auth-allow" = 1;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;
          "permissions.delegation.enabled" = false;
          # HEADERS / REFERERS
          "network.http.referer.defaultPolicy.trackers" = 1;
          "network.http.referer.defaultPolicy.trackers.pbmode" = 1;
          "network.http.referer.XOriginTrimmingPolicy" = 2;
          # CONTAINERS
          "privacy.userContext.ui.enabled" = true;
          # WEBRTC
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          # GOOGLE SAFE BROWSING
          "browser.safebrowsing.malware.enabled" = false;
          "browser.safebrowsing.phishing.enabled" = false;
          "browser.safebrowsing.downloads.enabled" = false;
          "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
          "browser.safebrowsing.downloads.remote.block_uncommon" = false;
          "browser.safebrowsing.blockedURIs.enabled" = false;
          # MOZILLA
          "identity.fxaccounts.enabled" = false;
          "browser.tabs.firefox-view" = false;
          "dom.push.enabled" = false;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 2;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "geo.provider.ms-windows-location" = false; # WINDOWS
          "geo.provider.use_corelocation" = false; # MAC
          "geo.provider.use_gpsd" = false; # LINUX
          "geo.provider.use_geoclue" = false; # LINUX
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
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "default-browser-agent.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          # SECTION: PESKYFOX
          # MOZILLA UI
          "layout.css.prefers-color-scheme.content-override" = 2;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "accessibility.force_disabled" = 1;
          "devtools.accessibility.enabled" = false;
          "browser.compactmode.show" = true;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "findbar.highlightAll" = true;
          "browser.privatebrowsing.enable-new-indicator" = false;
          # FULLSCREEN
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = 0;
          "full-screen-api.warning.timeout" = 0;
          # URL BAR
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          # NEW TAB PAGE
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          # POCKET
          "extensions.pocket.enabled" = false;
          # DOWNLOADS
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          # PDF
          "browser.download.open_pdf_attachments_inline" = true;
          # TAB BEHAVIOR
          "browser.link.open_newwindow.restriction" = 0;
          "dom.disable_window_move_resize" = true;
          "browser.tabs.loadBookmarksInTabs" = true;
          "browser.bookmarks.openInTabClosesMenu" = false;
          "clipboard.plainTextOnly" = true;
          "dom.popup_allowed_events" = "click dblclick";
          "layout.css.has-selector.enabled" = true;
        };
      };
    };
  };
}
