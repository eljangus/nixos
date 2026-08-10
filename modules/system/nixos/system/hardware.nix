{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.system.hardware.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      audio.enable = true;
    };
    hardware = {
      bluetooth.enable = true;
      cpu.amd.updateMicrocode = true;
      enableAllFirmware = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
