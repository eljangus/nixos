{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.starship.enable {
    programs = {
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
