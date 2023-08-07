{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
      noto-fonts
      noto-fonts-emoji
      roboto
      roboto-mono
      roboto-slab
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" "Noto Emoji" ];
        monospace = [ "Roboto Mono" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Slab" ];
      };
    };
  };
}
