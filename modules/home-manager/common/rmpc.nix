{
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in {
  options.myModules.home-manager.programs.rmpc.enable =
    lib.mkEnableOption "rmpc configuration";

  config = lib.mkIf config.myModules.home-manager.programs.rmpc.enable {
    home.packages = with pkgs; [
      rmpc
    ];
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Playlist";
      extraConfig = ''
        auto_update "yes"

        audio_output {
          type "${
          if isDarwin
          then "osx"
          else "pipewire"
        }"
          name "${
          if isDarwin
          then "CoreAudio"
          else "PipeWire"
        }"
          mixer_type "software"
        }
      '';
    };
  };
}
