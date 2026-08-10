{
  config,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf config.myModules.programs.common-pkgs.enable {
    environment.systemPackages = with pkgs; [
      # core
      killall
      nix-search-tv
      fzf
      eza
      fastfetch
      lazygit
      opencode
      opencode-claude-auth
      nixfmt

      # texteditor
      vscodium
    ];
  };
}
