{
  config,
  lib,
  ...
}: {
  options.myModules.system.nix.enable =
    lib.mkEnableOption "nix settings and configuration, such as enabling flakes and allowing unfree packages" // {default = true;};

  config = lib.mkIf config.myModules.system.nix.enable {
    nix = {
      settings = {
        warn-dirty = false;
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    nixpkgs.config = {
      permittedInsecurePackages = [
      ];
      allowUnfree = true;
    };
  };
}
