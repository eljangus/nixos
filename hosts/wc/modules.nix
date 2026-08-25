{config, ...}: let
  inherit (config.myModules) user;

  myHome = {
    programs = {
      kitty.enable = true;
    };
    theming = {
      gtk.enable = true;
      qt.enable = true;
      cursor.enable = true;
    };
  };
in {
  myModules = {
    desktop = "niri";
    programs = {
      gpu-screen-recorder.enable = true;
      obs.enable = true;
    };
    system = {
      overlays.enable = true;
      polkit.enable = true;
    };
  };

  home-manager.users.${user}.myModules.home-manager = myHome;
}
