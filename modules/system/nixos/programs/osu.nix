{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.programs.osu.enable =
    lib.mkEnableOption "osu!lazer and OpenTabletDriver";

  config = lib.mkIf config.myModules.programs.osu.enable {
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
