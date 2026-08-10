{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.polkit.enable {
    security.polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };
  };
}
