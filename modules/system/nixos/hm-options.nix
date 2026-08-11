{
  config,
  lib,
  ...
}: let
  enabled = {enable = lib.mkDefault true;};

  cfgDesktop = config.myModules.desktop;
in {
  options.myModules.home-manager = {
    programs = {
      hyprland.enable = lib.mkEnableOption "enable hyprland configuration";
      mangohud.enable = lib.mkEnableOption "enable mangohud configuration";
      niri.enable = lib.mkEnableOption "enable niri configuration";
      xdg.enable = lib.mkEnableOption "enable xdg mimeApps";
    };

    theming = {
      gtk.enable = lib.mkEnableOption "enable gtk theming";
      qt.enable = lib.mkEnableOption "enable qt5ct/qt6ct configuration";
      cursor.enable = lib.mkEnableOption "enable kitty cursor";
    };
  };

  config.myModules.home-manager = {
    programs = {
      # the window manager config follows whatever the host declares
      hyprland.enable = lib.mkDefault (cfgDesktop == "hyprland");
      niri.enable = lib.mkDefault (cfgDesktop == "niri");

      mangohud = enabled;
      xdg = enabled;
    };
  };
}
