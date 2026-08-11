{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules.home-manager = {
    programs = {
      fish.enable = lib.mkEnableOption "enable fish configuration";
      git.enable = lib.mkEnableOption "enable git configuration";
      nvf.enable = lib.mkEnableOption "enable nvf configuration";
      starship.enable = lib.mkEnableOption "enable starship configuration";
    };
  };

  config.myModules.home-manager = {
    programs = {
      fish = enabled;
      git = enabled;
      nvf = enabled;
      starship = enabled;
    };
  };
}
