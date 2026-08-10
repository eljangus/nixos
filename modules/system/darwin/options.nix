{
  config,
  lib,
  ...
}: let
  cfgOverlays = config.myModules.system.overlays;

  enabled = {enable = lib.mkDefault true;};

  overlayNames = [
  ];
in {
  options.myModules = {
    programs = {
      desktop-pkgs.enable = lib.mkEnableOption "enable desktop packages";
      omniwm.enable = lib.mkEnableOption "enable omniwm";
    };

    system = {
      homebrew.enable = lib.mkEnableOption "enable homebrew";
      touchid.enable = lib.mkEnableOption "enable touchid";
      overlays = {
        enable = lib.mkEnableOption "all overlays (master switch)";
      };
    };
  };

  config.myModules = {
    programs = {
      desktop-pkgs = enabled;
    };

    system =
      {
        homebrew = enabled;
        touchid = enabled;
      }
      // {
        overlays = lib.genAttrs overlayNames (_: {
          enable = lib.mkDefault cfgOverlays.enable;
        });
      };
  };
}
