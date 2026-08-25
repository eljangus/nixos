{
  config,
  osConfig,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.noctalia.enable =
    lib.mkEnableOption "noctalia configuration"
    // {
      default = lib.elem osConfig.myModules.desktop osConfig.myModules.noctaliaDesktops;
    };

  config = lib.mkIf config.myModules.home-manager.programs.noctalia.enable {
    xdg.stateFile."noctalia/settings.toml".source =
      config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos/assets/misc/settings.toml";
  };
}
