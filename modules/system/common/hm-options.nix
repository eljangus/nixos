{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules.home-manager = {
    programs = {
      btop.enable = lib.mkEnableOption "enable btop configuration";
      cava.enable = lib.mkEnableOption "enable cava configuration";
      fastfetch.enable = lib.mkEnableOption "enable fastfetch configuration";
      fish.enable = lib.mkEnableOption "enable fish configuration";
      git.enable = lib.mkEnableOption "enable git configuration";
      kitty.enable = lib.mkEnableOption "enable kitty configuration";
      nvf.enable = lib.mkEnableOption "enable nvf configuration";
      starship.enable = lib.mkEnableOption "enable starship configuration";
      direnv.enable = lib.mkEnableOption "enable direnv configuration";
    };
  };

  config.myModules.home-manager = {
    programs = {
      btop = enabled;
      cava = enabled;
      fastfetch = enabled;
      fish = enabled;
      git = enabled;
      nvf = enabled;
      starship = enabled;
      direnv = enabled;
    };
  };
}
