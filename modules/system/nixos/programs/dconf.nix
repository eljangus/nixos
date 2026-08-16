{
  config,
  lib,
  ...
}: {
  options.myModules.programs.dconf.enable =
    lib.mkEnableOption "dconf" // {default = true;};

  config = lib.mkIf config.myModules.programs.dconf.enable {
    programs.dconf.enable = true;
  };
}
