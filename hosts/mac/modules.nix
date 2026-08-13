{...}: {
  myModules = {
    programs = {
      omniwm.enable = true; # to declare it as installed via homebrew
    };
    home-manager = {
      programs = {
        kitty.enable = true;
        omniwm.enable = true; # to declare its configuration via nix
      };
    };
  };
}
