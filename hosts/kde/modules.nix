{config, ...}: let
  inherit (config.myModules) user;
  myHome = {
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
