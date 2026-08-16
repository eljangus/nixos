{
  config,
  lib,
  ...
}: {
  options.myModules.programs.fish.enable =
    lib.mkEnableOption "Fish shell" // {default = true;};

  config = lib.mkIf config.myModules.programs.fish.enable {
    programs.fish.enable = true;
  };
}
