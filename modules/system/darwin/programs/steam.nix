{
  config,
  lib,
  ...
}: {
  options.myModules.programs.steam.enable =
    lib.mkEnableOption "enable steam";

  config = lib.mkIf config.myModules.programs.steam.enable {
    homebrew.casks = ["steam"];
  };
}
