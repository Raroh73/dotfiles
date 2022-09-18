{ lib, ... }: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      document-font-name = "Noto Sans 11";
      font-antialiasing = "rgba";
      font-hinting = "slight";
      font-name = "Noto Sans 11";
      monospace-font-name = "Noto Sans Mono 11";
    };
    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Noto Sans Bold 11";
    };
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    "org/gnome/shell" = {
      disabled-extensions = lib.hm.gvariant.mkEmptyArray "s";
      enabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "discord.desktop"
        "spotify.desktop"
        "bitwarden.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = [
        "firefox.desktop:1"
        "code.desktop:2"
      ];
    };
  };
}
