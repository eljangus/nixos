{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.system.openrgb.enable {
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };
  };
}
