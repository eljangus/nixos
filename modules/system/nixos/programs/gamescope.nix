{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.gamescope.enable {
    programs.gamescope.enable = true;
  };
}
