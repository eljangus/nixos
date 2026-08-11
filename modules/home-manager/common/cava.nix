{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.cava.enable {
    programs.cava = {
      enable = true;

      settings = {
        color.theme = ''"noctalia"'';
      };
    };

    xdg.configFile = {
      "cava/shaders".source = ./_files/cava/shaders;
      "cava/themes/solarized_dark".source = ./_files/cava/themes/solarized_dark;
      "cava/themes/tricolor".source = ./_files/cava/themes/tricolor;
    };
  };
}
