{
  config,
  lib,
  ...
}: {
  options.myModules.home-manager.programs.vim.enable =
    lib.mkEnableOption "enable vim" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.vim.enable {
    home.sessionVariables = {
      EDITOR = "vim";
    };

    programs = {
      vim = {
        enable = true;
        settings = {
          expandtab = true;
          tabstop = 2;
          number = true;
          relativenumber = false;
          shiftwidth = 2;
          ignorecase = true;
          smartcase = true;
          mouse = "a";
          undofile = false;
        };

        extraConfig = ''
          syntax on
          filetype plugin indent on
          set hlsearch
          set incsearch
          set noswapfile
          if executable('wl-copy')
          xnoremap "+y y:call system("wl-copy", @")<cr>
          nnoremap "+p :let @+ = system("wl-paste --no-newline")<cr>"+p
          nnoremap "*p :let @* = system("wl-paste --no-newline --primary")<cr>"*p
          endif
        '';
      };

      starship = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
