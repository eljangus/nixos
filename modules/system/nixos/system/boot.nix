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

      # Load amdgpu in the initrd so KMS takes over the console (and thus
      # greetd/tuigreet's tty) at its native mode/refresh from early boot,
      # instead of staying on a low-res simpledrm/efifb fallback.
      initrd.kernelModules = ["amdgpu"];
      kernelParams = [
        "video=DP-1:2560x1440@240"
        "video=DP-2:1920x1080@240"
      ];
    };
  };
}
