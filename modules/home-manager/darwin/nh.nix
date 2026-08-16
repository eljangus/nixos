{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.nh.enable =
    lib.mkEnableOption "enable nix helper" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.nh.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = false;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
    };
  };
}
