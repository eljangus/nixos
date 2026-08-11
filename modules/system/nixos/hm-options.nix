{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules.home-manager = {
    programs = {
      xdg.enable = lib.mkEnableOption "enable xdg mimeApps";
    };
  };

  config.myModules.home-manager = {
    programs = {
      xdg = enabled;
    };
  };
}
