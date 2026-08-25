{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.rofi.enable =
    lib.mkEnableOption "rofi configuration";

  config = lib.mkIf config.myModules.home-manager.programs.rofi.enable {
    programs.rofi = {
      enable = true;
      font = "Maple Mono NF 11";
      terminal = "kitty";
      theme = ./_files/rofi/tokyo-night-moon.rasi;
    };
  };
}
