{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.git.enable =
    lib.mkEnableOption "git configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.git.enable {
    programs.git = {
      enable = true;
      ignores = [".direnv/" ".envrc.local"];
      settings = {
        user = {
          name = "Elias Schlosser";
          email = "eljangus@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
