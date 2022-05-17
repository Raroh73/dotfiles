{ ... }: {
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      "night-light-enabled" = true;
      "night-light-schedule-automatic" = true;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "code.desktop"
        "steam.desktop"
        "discord.desktop"
        "spotify.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
