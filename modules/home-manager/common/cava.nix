{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  hasNoctalia = !isDarwin && lib.elem osConfig.myModules.desktop osConfig.myModules.noctaliaDesktops;
in {
  options.myModules.home-manager.programs.cava.enable =
    lib.mkEnableOption "cava configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.cava.enable {
    programs.cava = {
      enable = true;

      settings = lib.mkIf hasNoctalia {
        color.theme = ''"noctalia"'';
      };
    };
  };
}
