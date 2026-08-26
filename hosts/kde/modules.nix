{config, ...}: let
  inherit (config.myModules) user;
  myHome = {
    programs = {
      kitty.enable = true;
    };
    theming = {
      cursor.enable = true;
    };
  };
in {
  myModules = {
    desktop = "plasma";
  };
  home-manager.users.${user}.myModules.home-manager = myHome;
}
