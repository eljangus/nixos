{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.system.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      adwaita-fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
    ];
  };
}
