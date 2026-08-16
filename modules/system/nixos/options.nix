{lib, ...}: {
  options.myModules = {
    system.overlays.enable = lib.mkEnableOption "all overlays (master switch)";

    desktop = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "gnome"
          "plasma"
          "hyprland"
          "niri"
        ]
      );
      default = null;
      description = "Which desktop/window manager this host runs";
    };
  };
}
