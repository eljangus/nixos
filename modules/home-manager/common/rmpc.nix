{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.home-manager.programs.rmpc.enable =
    lib.mkEnableOption "rmpc configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.rmpc.enable {
    home.pacakges = with pkgs; [
      rmpc
    ];
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Playlist";
    };
  };
}
