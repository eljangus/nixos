{
  config,
  lib,
  ...
}: {
  options.myModules.programs.zen.enable =
    lib.mkEnableOption "enable zen" // {default = true;};

  config = lib.mkIf config.myModules.programs.zen.enable {
    homebrew.casks = ["zen"];
  };
}
