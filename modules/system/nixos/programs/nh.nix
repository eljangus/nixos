{
  config,
  lib,
  ...
}: {
  options.myModules.programs.nh.enable =
    lib.mkEnableOption "nh" // {default = true;};

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
