{
  config,
  lib,
  ...
}: {
  options.myModules.system.polkit.enable =
    lib.mkEnableOption "polkit wrapper";

  config = lib.mkIf config.myModules.system.polkit.enable {
    security.polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };
  };
}
