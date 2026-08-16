{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.direnv.enable =
    lib.mkEnableOption "direnv configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
      config.global = {
        hide_env_diff = true;
        warn_timeout = "30s";
      };
    };
  };
}
