{config, ...}: let
  inherit (config.myModules) user;

  myHome = {
    kitty.enable = true;
    omniwm.enable = true; # nix-managed config
    zed.enable = true;
  };
in {
  myModules.programs.omniwm.enable = true; # installed via homebrew

  home-manager.users.${user}.myModules.home-manager.programs = myHome;
}
