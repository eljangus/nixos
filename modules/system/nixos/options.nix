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

    noctaliaDesktops = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["niri" "hyprland"];
      description = "Desktops that run the noctalia shell and get noctalia theming";
    };
  };
}
