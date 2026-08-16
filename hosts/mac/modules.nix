{config, ...}: {
  myModules.programs.omniwm.enable = true; # installed via homebrew

  home-manager.users.${config.myModules.user}.myModules.home-manager.programs = {
    kitty.enable = true;
    omniwm.enable = true; # nix-managed config
  };
}
