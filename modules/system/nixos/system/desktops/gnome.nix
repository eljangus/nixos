{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.myModules.desktop == "gnome") {
    services.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
  };
}
