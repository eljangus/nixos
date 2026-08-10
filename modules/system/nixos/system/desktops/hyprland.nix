{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.myModules.desktop == "hyprland") {
    programs.hyprland.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };
}
