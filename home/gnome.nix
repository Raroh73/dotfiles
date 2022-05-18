{ lib, ... }: {
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      "night-light-enabled" = true;
      "night-light-schedule-automatic" = true;
    };
    "org/gnome/shell" = {
      disabled-extensions = lib.hm.gvariant.mkEmptyArray "s";
      enabled-extensions = [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "steam.desktop"
        "discord.desktop"
        "spotify.desktop"
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
