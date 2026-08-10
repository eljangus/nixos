{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.programs.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = ["de"];
    };
  };
}
