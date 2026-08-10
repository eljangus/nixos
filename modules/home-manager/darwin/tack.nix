{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.tack.enable {
    home.sessionVariables = {
      TACK_NIX_CONF_TOKENS = "1";
    };
  };
}
