{
  config,
  lib,
  ...
}: let
  cfgOverlays = config.myModules.system.overlays;

  enabled = {enable = lib.mkDefault true;};

  overlayNames = [
    "qt6ct-kde"
    "swash"
  ];
in {
  options.myModules = {
    programs = {
      dconf.enable = lib.mkEnableOption "dconf";
      desktop-pkgs.enable = lib.mkEnableOption "enable desktop packages";
      gamescope.enable = lib.mkEnableOption "Gamescope";
      gpu-screen-recorder.enable = lib.mkEnableOption "GPU Screen Recorder";
      nh.enable = lib.mkEnableOption "nh";
      steam.enable = lib.mkEnableOption "Steam";
      tack.enable = lib.mkEnableOption "tack";
      zen.enable = lib.mkEnableOption "zen browser";
    };

    system = {
      amdgpu.enable = lib.mkEnableOption "amdgpu video driver";
      boot.enable = lib.mkEnableOption "bootloader and kernel settings";
      environment.enable = lib.mkEnableOption "general environment stuff I want enabled";
      hardware.enable = lib.mkEnableOption "common hardware configuration (bluetooth, graphics, microcode)";
      locale.enable = lib.mkEnableOption "enable locale";
      openrgb.enable = lib.mkEnableOption "OpenRGB";
      openssh.enable = lib.mkEnableOption "enable openssh";
      polkit.enable = lib.mkEnableOption "polkit wrapper";
      time.enable = lib.mkEnableOption "enable time related configurations";
      udev.enable = lib.mkEnableOption "udev rules";
      xkb.enable = lib.mkEnableOption "xkb to de";

      overlays = {
        enable = lib.mkEnableOption "all overlays (master switch)";
        qt6ct-kde.enable = lib.mkEnableOption "qt6ct-kde overlay";
        swash.enable = lib.mkEnableOption "swash overlay";
      };
    };

    desktop = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "gnome"
          "plasma"
          "hyprland"
          "niri"
        ]
      );
      default = null;
      description = "Which desktop/window manager this host runs";
    };
  };

  config.myModules = {
    programs = {
      dconf = enabled;
      desktop-pkgs = enabled;
      nh = enabled;
      steam = enabled;
      tack = enabled;
      zen = enabled;
    };

    system =
      {
        amdgpu = enabled;
        boot = enabled;
        environment = enabled;
        hardware = enabled;
        locale = enabled;
        openssh = enabled;
        xkb = enabled;
        time = enabled;
      }
      // {
        overlays = lib.genAttrs overlayNames (_: {
          enable = lib.mkDefault cfgOverlays.enable;
        });
      };
  };
}
