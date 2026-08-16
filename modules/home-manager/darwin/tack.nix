{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.tack.enable =
    lib.mkEnableOption "enable tack home.sessionVariable" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.tack.enable {
    home.sessionVariables = {
      TACK_NIX_CONF_TOKENS = "1";
    };
  };
}
