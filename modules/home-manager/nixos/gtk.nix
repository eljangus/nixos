{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  noctaliaCss = version: ''
    @import url("file://${config.xdg.configHome}/gtk-${version}/noctalia.css");
  '';
in {
  config = lib.mkIf osConfig.myModules.home-manager.theming.gtk.enable {
    gtk = {
      enable = true;

      font = {
        name = "Adwaita Sans";
        size = 11;
      };

      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
      };

      colorScheme = "dark";

      gtk3 = {
        extraCss = noctaliaCss "3.0";

        extraConfig = {
          gtk-button-images = 0;
          gtk-cursor-blink = true;
          gtk-cursor-blink-time = 1000;
          gtk-decoration-layout = "icon:minimize,maximize,close";
          gtk-enable-animations = true;
          gtk-enable-event-sounds = 1;
          gtk-enable-input-feedback-sounds = 0;
          gtk-menu-images = 0;
          gtk-modules = "colorreload-gtk-module";
          gtk-primary-button-warps-slider = true;
          gtk-sound-theme-name = "ocean";
          gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
          gtk-toolbar-style = 3;
          gtk-xft-antialias = 1;
          gtk-xft-dpi = 98304;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";
        };

        bookmarks = [
          "file://${config.home.homeDirectory}/.config .config"
          "file:/// /"
          "file://${config.home.homeDirectory}/.local .local"
          "file://${config.home.homeDirectory}/nixos nixos"
        ];
      };

      gtk4 = {
        extraCss = noctaliaCss "4.0";

        extraConfig = {
          gtk-cursor-blink = true;
          gtk-cursor-blink-time = 1000;
          gtk-decoration-layout = "icon:minimize,maximize,close";
          gtk-enable-animations = true;
          gtk-primary-button-warps-slider = true;
          gtk-sound-theme-name = "ocean";
          gtk-xft-dpi = 98304;
        };
      };
    };
  };
}
