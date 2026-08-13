{...}: {
  myModules = {
    programs = {
      omniwm.enable = true;
    };
    home-manager = {
      programs = {
        kitty.enable = true;
        omniwm.enable = true;
      };
    };
  };
}
