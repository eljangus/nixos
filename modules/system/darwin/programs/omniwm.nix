{
  config,
  lib,
  ...
}: {
  options.myModules.programs.omniwm.enable =
    lib.mkEnableOption "enable omniwm";

  config = lib.mkIf config.myModules.programs.omniwm.enable {
    homebrew.taps = ["BarutSRB/tap"];
    homebrew.casks = ["BarutSRB/tap/omniwm"];
  };
}
