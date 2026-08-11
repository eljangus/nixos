{lib, ...}: let
  enabled = {enable = lib.mkDefault true;};
in {
  options.myModules = {
    programs = {
      common-pkgs.enable = lib.mkEnableOption "common pkgs";
      fish.enable = lib.mkEnableOption "Fish shell";
      zen.enable = lib.mkEnableOption "zen browser";
    };

    system = {
      fonts.enable = lib.mkEnableOption "fonts";
      nix.enable = lib.mkEnableOption "nix settings and configuration, such as enabling flakes and allowing unfree packages";
    };
  };

  config.myModules = {
    programs = {
      common-pkgs = enabled;
      fish = enabled;
      zen = enabled;
    };

    system = {
      fonts = enabled;
      nix = enabled;
    };
  };
}
