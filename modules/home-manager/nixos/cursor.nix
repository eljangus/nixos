{
  self,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  kitty-cursor = pkgs.runCommandLocal "kitty-cursor" {} ''
    mkdir -p $out/share/icons
    cp -r ${self + "/assets/cursor/kitty-cursor"} $out/share/icons/kitty-cursor
    chmod -R u+w $out/share/icons/kitty-cursor
  '';
  bunny-cursor = pkgs.runCommandLocal "bunny-cursor" {} ''
    mkdir -p $out/share/icons
    cp -r ${self + "/assets/cursor/bunny-cursor"} $out/share/icons/bunny-cursor
    chmod -R u+w $out/share/icons/bunny-cursor
  '';
in {
  config = lib.mkIf osConfig.myModules.home-manager.theming.cursor.enable {
    home.pointerCursor = {
      enable = true;
      gtk.enable = true;
      x11.enable = true;
      name = "bunny-cursor";
      size = 24;
      package = bunny-cursor;
    };
  };
}
