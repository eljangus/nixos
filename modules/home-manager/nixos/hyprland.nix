{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.hyprland.enable {
    xdg.configFile."hypr/hyprland.lua".source = ./_files/hypr/hyprland.lua;
  };
}
