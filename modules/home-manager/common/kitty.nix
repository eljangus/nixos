{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  themeName =
    if isDarwin
    then "rose-pine"
    else if lib.elem osConfig.myModules.desktop osConfig.myModules.noctaliaDesktops
    then "noctalia"
    else if osConfig.myModules.desktop == "dwm"
    then "tokyo-night-moon"
    else "one-dark";
in {
  options.myModules.home-manager.programs.kitty.enable =
    lib.mkEnableOption "kitty configuration";

  config = lib.mkIf config.myModules.home-manager.programs.kitty.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = "Maple Mono NF";
        size = 14;
      };

      settings =
        {
          allow_remote_control = "yes";
          background_blur = 0;
          background_opacity = "0.8";
          confirm_os_window_close = 0;
          cursor_trail = 5;
          hide_window_decorations = "yes";
          placement_strategy = "top-left";
          resize_debounce_time = "0 0";
          scrollbar = "never";
          window_padding_width = 20;
        }
        // lib.optionalAttrs isDarwin {
          background_blur = 24;
          hide_window_decorations = "no";
          macos_titlebar_color = "background";
        };

      keybindings = {
        "shift+cmd+backspace" = "change_font_size all 14";
        "shift+cmd+minus" = "change_font_size all -2.0";
        "shift+cmd+plus" = "change_font_size all +2.0";
      };

      extraConfig = ''
        include ${config.xdg.configHome}/kitty/themes/${themeName}.conf
      '';
    };

    xdg.configFile =
      {
        "kitty/themes/one-dark.conf".source = ./_files/kitty/themes/one-dark.conf;
      }
      // lib.optionalAttrs (themeName == "tokyo-night-moon") {
        "kitty/themes/tokyo-night-moon.conf".source = ./_files/kitty/themes/tokyo-night-moon.conf;
      }
      // lib.optionalAttrs (themeName == "rose-pine") {
        "kitty/themes/rose-pine.conf".source = ./_files/kitty/themes/rose-pine.conf;
      };
  };
}
