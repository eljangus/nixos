{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules = {
    programs = {
      common-pkgs.enable = lib.mkEnableOption "common pkgs";
      fish.enable = lib.mkEnableOption "Fish shell";
    };

    system = {
      fonts.enable = lib.mkEnableOption "fonts";
      nix.enable = lib.mkEnableOption "nix settings and configuration, such as enabling flakes and allowing unfree packages";
      time.enable = lib.mkEnableOption "timezone";
    };
  };

  config.myModules = {
    programs = {
      common-pkgs = enabled;
      fish = enabled;
    };

    system = {
      fonts = enabled;
      nix = enabled;
      time = enabled;
    };
  };
}
