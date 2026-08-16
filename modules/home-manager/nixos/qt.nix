{
  config,
  lib,
  ...
}: let
  qt5Font = ''"Adwaita Sans,11,-1,5,50,0,0,0,0,0,Regular"'';
  qt6Font = ''"Adwaita Sans,11,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular,0,0"'';

  interface = {
    activate_item_on_single_click = 1;
    buttonbox_layout = 0;
    cursor_flash_time = 1000;
    dialog_buttons_have_icons = 1;
    double_click_interval = 400;
    gui_effects = "@Invalid()";
    keyboard_scheme = 2;
    menus_have_icons = true;
    show_shortcuts_in_context_menus = true;
    stylesheets = "@Invalid()";
    toolbutton_style = 4;
    underline_shortcut = 1;
    wheel_scroll_lines = 3;
  };

  troubleshooting = {
    force_raster_widgets = 1;
    ignored_applications = "@Invalid()";
  };
in {
  options.myModules.home-manager.theming.qt.enable =
    lib.mkEnableOption "qt5ct/qt6ct configuration";

  config = lib.mkIf config.myModules.home-manager.theming.qt.enable {
    qt = {
      enable = true;

      qt5ctSettings = {
        Appearance = {
          color_scheme_path = "${config.xdg.configHome}/qt5ct/colors/noctalia.conf";
          custom_palette = true;
          icon_theme = "breeze-dark";
          standard_dialogs = "default";
          style = "Fusion";
        };
        Fonts = {
          fixed = qt5Font;
          general = qt5Font;
        };
        Interface = interface;
        Troubleshooting = troubleshooting;
      };

      qt6ctSettings = {
        Appearance = {
          color_scheme_path = "${config.xdg.dataHome}/color-schemes/noctalia.colors";
          custom_palette = true;
          icon_theme = "breeze-dark";
          standard_dialogs = "default";
          style = "Fusion";
        };
        Fonts = {
          fixed = qt6Font;
          general = qt6Font;
        };
        Interface = interface;
        Troubleshooting = troubleshooting;
      };
    };
  };
}
