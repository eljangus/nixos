{
  config,
  lib,
  pkgs,
  ...
}: let
  # Tokyo Night Moon clock/RAM/CPU status text, coloured via the dwm
  # status2d patch. Replaces services.dwm-status (nixpkgs' Gerschtli/dwm-status):
  # that one has no RAM block and no way to colour individual segments.
  statusbar = pkgs.writeShellApplication {
    name = "dwm-statusbar";
    runtimeInputs = with pkgs; [gawk xsetroot];
    text = builtins.readFile ./_files/dwm/statusbar.sh;
  };
in {
  config = lib.mkIf (config.myModules.desktop == "dwm") {
    services.xserver.enable = true;

    services.xserver.windowManager.dwm = {
      enable = true;
      extraSessionCommands = ''
        # X11 (amdgpu/Xorg) names these DisplayPort-0/1, unlike the DP-1/DP-2
        # DRM names Wayland (hyprland.lua/niri config.kdl) uses for the same
        # two outputs -- mirror the same modes/refresh/positions here.
        xrandr \
          --output DisplayPort-0 --mode 2560x1440 --rate 240 --pos 0x0 \
          --output DisplayPort-1 --mode 1920x1080 --rate 239.96 --pos -1920x180
        xwallpaper --zoom ~/wallpapers/Walls/Tony.png &
        openrgb &
        easyeffects --gapplication-service &
      '';
      package = pkgs.dwm.override {
        conf = builtins.readFile ./_files/dwm/config.h;
        extraLibs = [pkgs.libxcursor];
        # Vendored locally (not pkgs.fetchpatch) so the build doesn't depend
        # on dwm.suckless.org being reachable/unchanged, and so `git blame`
        # applies directly to the patch content.
        patches = [
          # new clients attach at the bottom of the stack instead of becoming master
          ./_files/dwm/patches/attachbottom.diff
          # single-value gaps (MODKEY +/-/Shift++ to adjust at runtime)
          ./_files/dwm/patches/fullgaps.diff
          # move the focused client through the stack (MODKEY+Shift+j/k), for hyprland-like window movement
          ./_files/dwm/patches/movestack.diff
          # cycle to the prev/next tag (MODKEY+a/d), for hyprland-like workspace switching
          ./_files/dwm/patches/cycleview.diff
          # toggle a borderless monocle "fullscreen" (Ctrl+Shift+f), matching hyprland's fullscreen toggle
          ./_files/dwm/patches/fullscreen.diff
          # load the root/resize/move cursors from the Xcursor theme instead of
          # the hardcoded X core cursor font -- without this dwm ignores
          # home.pointerCursor (bunny-cursor) everywhere except inside windows
          # that set their own cursor themselves (e.g. kitty), leaving the
          # plain default arrow over the empty background
          ./_files/dwm/patches/xcursor.diff
          # render ^c#RRGGBB^/^b#RRGGBB^/^d^ colour codes in the status text,
          # for the per-block Tokyo Night colours in the dwm-status-replacement script
          ./_files/dwm/patches/status2d.diff
        ];
      };
    };

    services.xserver.displayManager.startx = {
      enable = true;
      generateScript = true;
    };

    systemd.user.services.dwm-statusbar = {
      description = "dwm status bar (clock/RAM/CPU, Tokyo Night Moon)";
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
      serviceConfig.ExecStart = "${statusbar}/bin/dwm-statusbar";
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
