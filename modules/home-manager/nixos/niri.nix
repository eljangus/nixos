{
  config,
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.niri.enable {
    wayland.windowManager.niri = {
      enable = true;

      # niri, xwayland-satellite, the portals and the systemd units all come
      # from myModules.desktop == "niri" on the system side. This module only
      # writes ~/.config/niri/config.kdl.
      package = null;
      systemd.enable = false;
      xwaylandSatellitePackage = null;
      portalPackage = null;
      checkConfig = false;

      # The config is kept as KDL rather than translated to `settings`, so it
      # stays diffable against upstream niri examples. Move blocks into
      # `settings` piecemeal whenever you feel like it, they are merged.
      extraConfig = ''
        ${builtins.readFile ./_files/niri/config.kdl}
        include optional=true "${config.xdg.configHome}/niri/noctalia.kdl"
      '';
    };
  };
}
