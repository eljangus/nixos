{
  config,
  lib,
  ...
}: {
  options.myModules.system.homebrew.enable =
    lib.mkEnableOption "enable homebrew" // {default = true;};

  config = lib.mkIf config.myModules.system.homebrew.enable {
    homebrew = {
      enable = true;
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
