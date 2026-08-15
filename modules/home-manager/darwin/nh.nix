{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = false;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
    };
  };
}
