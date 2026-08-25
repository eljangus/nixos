{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  hasNoctalia = !isDarwin && lib.elem osConfig.myModules.desktop osConfig.myModules.noctaliaDesktops;
  isDwm = !isDarwin && osConfig.myModules.desktop == "dwm";
in {
  options.myModules.home-manager.programs.cava.enable =
    lib.mkEnableOption "cava configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.cava.enable {
    programs.cava =
      {
        enable = true;
      }
      // lib.optionalAttrs hasNoctalia {
        settings.color.theme = ''"noctalia"'';
      }
      // lib.optionalAttrs isDwm {
        # Tokyo Night Moon, matching
        # modules/home-manager/common/_files/kitty/themes/tokyo-night-moon.conf
        settings.color = {
          background = "'default'";
          foreground = "'default'";
          gradient = 1;
          gradient_count = 3;
          gradient_color_1 = "'#c3e88d'"; # green
          gradient_color_2 = "'#ffc777'"; # yellow
          gradient_color_3 = "'#ff757f'"; # red
        };
      };
  };
}
