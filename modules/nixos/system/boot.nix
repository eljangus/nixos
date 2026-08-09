{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.boot.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
