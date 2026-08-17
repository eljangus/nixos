{
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  options.myModules.home-manager.programs.cava.enable =
    lib.mkEnableOption "cava configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.cava.enable {
    programs.cava = {
      enable = true;

      settings = lib.mkIf (!isDarwin) {
        color.theme = ''"noctalia"'';
      };
    };
  };
}
