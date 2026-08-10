{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.time.enable {
    time.timeZone = "Europe/Berlin";
  };
}
