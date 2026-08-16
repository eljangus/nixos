{
  config,
  osConfig,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.hyprland.enable =
    lib.mkEnableOption "hyprland configuration"
    // {
      default = osConfig.myModules.desktop == "hyprland";
    };

  config = lib.mkIf config.myModules.home-manager.programs.hyprland.enable {
    xdg.configFile."hypr/hyprland.lua".source = ./_files/hypr/hyprland.lua;
  };
}
