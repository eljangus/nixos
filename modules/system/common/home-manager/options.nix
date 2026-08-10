{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules.home-manager = {
    programs = {
      xdg.enable = lib.mkEnableOption "xdg-mimeApps";
      fish.enable = lib.mkEnableOption "enable fish configuration";
      git.enable = lib.mkEnableOption "enable git configuration";
      nvf.enable = lib.mkEnableOption "enable nvf configuration";
      starship.enable = lib.mkEnableOption "enable starship configuration";
    };
  };

  config.myModules.home-manager = {
    programs = {
      xdg = enabled;
      fish = enabled;
      git = enabled;
      nvf = enabled;
      starship = enabled;
    };
  };
}
