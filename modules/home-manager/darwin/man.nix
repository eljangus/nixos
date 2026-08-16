{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.man.enable =
    lib.mkEnableOption "manpage configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.man.enable {
    programs.man.generateCaches = false;
  };
}
