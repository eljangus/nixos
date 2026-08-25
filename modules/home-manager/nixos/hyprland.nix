{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}: let
  scrolloverview = pkgs.hyprlandPlugins.mkHyprlandPlugin (_finalAttrs: {
    pluginName = "scrolloverview";
    version = "main";
    src = inputs.scroll-overview;

    nativeBuildInputs = [pkgs.cmake];
    buildInputs = [pkgs.lua5_4];

    meta.license = lib.licenses.free;
  });
in {
  options.myModules.home-manager.programs.hyprland.enable =
    lib.mkEnableOption "hyprland configuration"
    // {
      default = osConfig.myModules.desktop == "hyprland";
    };

  config = lib.mkIf config.myModules.home-manager.programs.hyprland.enable {
    xdg.configFile."hypr/hyprland.lua".text = builtins.replaceStrings
      ["@SCROLLOVERVIEW_SO@"]
      ["${scrolloverview}/lib/lib${scrolloverview.pname}.so"]
      (builtins.readFile ./_files/hypr/hyprland.lua);

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      plugins = [scrolloverview];
    };
  };
}
