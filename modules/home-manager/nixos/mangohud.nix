{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.mangohud.enable =
    lib.mkEnableOption "mangohud configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.mangohud.enable {
    programs.mangohud = {
      enable = true;

      settings = {
        gpu_stats = true;
        gpu_temp = true;
        gpu_text = "RX 9070XT";
        gpu_list = 0;
        cpu_stats = true;
        cpu_temp = true;
        cpu_text = "R7 9800x3d";
        cpu_mhz = true;
        vram = true;
        ram = true;
        fps = true;
        frametime = true;
        frame_timing = true;
        text_outline = true;
        offset_x = 20;
        offset_y = 20;
      };
    };
  };
}
