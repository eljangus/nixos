{
  pkgs,
  config,
  lib,
  ...
}: {
  options.myModules.system.boot.enable =
    lib.mkEnableOption "bootloader and kernel settings" // {default = true;};

  config = lib.mkIf config.myModules.system.boot.enable {
    boot = {
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
