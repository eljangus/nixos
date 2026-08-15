{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = false;
        extraArgs = "--keep 5 --keep-since 3d";
        dates = "weekly";
      };
    };
  };
}
