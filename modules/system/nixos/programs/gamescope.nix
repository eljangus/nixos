{
  config,
  lib,
  ...
}: {
  options.myModules.programs.gamescope.enable =
    lib.mkEnableOption "Gamescope";

  config = lib.mkIf config.myModules.programs.gamescope.enable {
    programs.gamescope.enable = true;
  };
}
