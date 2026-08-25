{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (config.myModules.desktop == "dwm") {
    services.xserver.enable = true;
    services.dwm-status.enable = true;

    services.xserver.windowManager.dwm = {
      enable = true;
      extraSessionCommands = ''
        xwallpaper --zoom ~/wallpapers/Walls/tony.png &
        openrgb &
        easyeffects --gapplication-service &
      '';
      package = pkgs.dwm.override {
        conf = builtins.readFile ./_files/dwm/config.h;
        patches = [
          # new clients attach at the bottom of the stack instead of becoming master
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/attachbottom/dwm-attachbottom-6.8.diff";
            hash = "sha256-6eI+EpbokY9oJKUFVGLabNkA1yxsfISR0uiZZWhKDDU=";
          })
          # single-value gaps (MODKEY +/-/Shift+= to adjust at runtime)
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/fullgaps/dwm-fullgaps-6.4.diff";
            hash = "sha256-+OXRqnlVeCP2Ihco+J7s5BQPpwFyRRf8lnVsN7rm+Cc=";
          })
          # move the focused client through the stack (MODKEY+Shift+j/k), for hyprland-like window movement
          ./_files/dwm/patches/movestack.diff
          # cycle to the prev/next tag (MODKEY+a/d), for hyprland-like workspace switching
          (pkgs.fetchpatch {
            url = "https://dwm.suckless.org/patches/cycleview/dwm-cycleview-20241121-0a129d5f.diff";
            hash = "sha256-OYtDj1JMFEeam8+kd+yE30/ytX7VcjpXZmWtLBCosS8=";
          })
          # toggle a borderless monocle "fullscreen" (Ctrl+Shift+f), matching hyprland's fullscreen toggle
          ./_files/dwm/patches/fullscreen.diff
        ];
      };
    };

    services.xserver.displayManager.startx = {
      enable = true;
      generateScript = true;
    };

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd startx";
    };

    environment.systemPackages = with pkgs; [
      xwallpaper
      dmenu
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };
}
