{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.homebrew.enable {
    homebrew = {
      enable = true;
      onActivation = {
        cleanup = "zap";
        autoUpdate = false;
        upgrade = false;
      };
    };
  };
}
