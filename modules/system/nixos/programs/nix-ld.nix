{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.programs.nix-ld.enable =
    lib.mkEnableOption "nix-ld" // {default = true;};

  config = lib.mkIf config.myModules.programs.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        openssl
        curl
        icu
      ];
    };
  };
}
