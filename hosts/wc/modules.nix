{...}: {
  myModules = {
    desktop = "niri";
    programs = {
      gpu-screen-recorder.enable = true;
    };
    system = {
      overlays.enable = true;
      overlays.glaze.enable = false;
      polkit.enable = true;
    };
    home-manager = {
      programs = {
        kitty.enable = true;
      };
      theming = {
        gtk.enable = true;
        qt.enable = true;
      };
    };
  };
}
