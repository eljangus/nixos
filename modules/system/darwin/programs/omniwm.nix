{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.omniwm.enable {
    homebrew.taps = ["BarutSRB/tap"];
    homebrew.casks = ["BarutSRB/tap/omniwm"];
  };
}
