{
  config,
  lib,
  ...
}: {
  options.myModules.system.time.enable =
    lib.mkEnableOption "enable time related configurations" // {default = true;};

  config = lib.mkIf config.myModules.system.time.enable {
    time.timeZone = "Europe/Berlin";
  };
}
