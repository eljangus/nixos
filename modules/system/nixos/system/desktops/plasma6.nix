{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.myModules.desktop == "plasma") {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
  };
}
