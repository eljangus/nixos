{
  config,
  lib,
  ...
}: {
  options.myModules.programs.gpu-screen-recorder.enable =
    lib.mkEnableOption "GPU Screen Recorder";

  config = lib.mkIf config.myModules.programs.gpu-screen-recorder.enable {
    programs.gpu-screen-recorder.enable = true;
  };
}
