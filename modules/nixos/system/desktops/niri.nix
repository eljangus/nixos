{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.myModules.desktop == "niri") {
    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
  };
}
