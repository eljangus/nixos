{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.system.fonts.enable =
    lib.mkEnableOption "fonts" // {default = true;};

  config = lib.mkIf config.myModules.system.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      adwaita-fonts
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      maple-mono.NF
    ];
  };
}
