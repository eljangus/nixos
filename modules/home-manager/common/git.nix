{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.git.enable {
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
