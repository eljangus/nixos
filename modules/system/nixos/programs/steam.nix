{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.programs.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
