{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.homebrew.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        extraFlags = ["--force-cleanup"];
        upgrade = true;
      };
    };
  };
}
