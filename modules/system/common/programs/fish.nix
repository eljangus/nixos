{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.fish.enable {
    programs.fish.enable = true;
  };
}
