{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.myModules.system.nix.enable {
    nix = {
      settings = {
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
