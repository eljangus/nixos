{lib, ...}: {
  options.myModules = {
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
