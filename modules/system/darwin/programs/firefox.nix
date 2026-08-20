{
  config,
  lib,
  ...
}: {
  options.myModules.programs.firefox.enable =
    lib.mkEnableOption "enable firefox" // {default = true;};

  config = lib.mkIf config.myModules.programs.firefox.enable {
    homebrew.casks = ["firefox"];
  };
}
