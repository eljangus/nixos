{
  config,
  osConfig,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.noctalia.enable =
    lib.mkEnableOption "noctalia configuration"
    // {
      default = lib.elem osConfig.myModules.desktop ["niri" "hyprland"];
    };

  config = lib.mkIf config.myModules.home-manager.programs.noctalia.enable {
    xdg.configFile."noctalia/settings.toml".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos/assets/misc/settings.toml";
  };
}
