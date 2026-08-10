{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules.home-manager = {
    programs = {
      man.enable = lib.mkEnableOption "manpage configuration";
      nh.enable = lib.mkEnableOption "enable nix helper";
      tack.enable = lib.mkEnableOption "enable tack home.sessionVariable";
    };
  };

  config.myModules.home-manager = {
    programs = {
      man = enabled;
      nh = enabled;
      tack = enabled;
    };
  };
}
