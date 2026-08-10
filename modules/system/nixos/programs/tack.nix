{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.tack.enable {
    programs.tack.enable = true;
  };
}
