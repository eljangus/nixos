{config, ...}: let
  inherit (config.myModules) user;

  myHome = {
    programs = {
      kitty.enable = true;
      rofi.enable = true;
    };
    theming = {
      cursor.enable = true;
    };
  };
in {
  myModules = {
    desktop = "dwm";
    programs = {
      obs.enable = true;
    };
  };

  home-manager.users.${user}.myModules.home-manager = myHome;
}
