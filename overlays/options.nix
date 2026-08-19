{lib, ...}: {
  options.myModules = {
    system.overlays.enable = lib.mkEnableOption "all overlays (master switch)";
  };
}
