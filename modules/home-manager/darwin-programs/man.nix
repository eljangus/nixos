{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.man.enable {
    programs.man.generateCaches = false;
  };
}
