{
  config,
  lib,
  pkgs,
  ...
}: {
  options.myModules.programs.common-pkgs.enable =
    lib.mkEnableOption "common pkgs" // {default = true;};

  config = lib.mkIf config.myModules.programs.common-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # core
      killall
      nix-search-tv
      fzf
      eza
      lazygit
      opencode
      claude-code
      nixfmt
      sccache
    ];
  };
}
