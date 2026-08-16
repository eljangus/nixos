{
  config,
  lib,
  ...
}: {
  options.myModules.programs.tack.enable =
    lib.mkEnableOption "tack" // {default = true;};

  config = lib.mkIf config.myModules.programs.tack.enable {
    programs.tack = {
      enable = true;
      nixConfTokens = true;
    };
  };
}
