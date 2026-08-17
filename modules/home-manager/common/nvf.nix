{
  config,
  lib,
  pkgs,
  ...
}: let
  configFindFiles = "require('telescope.builtin').find_files({ cwd = '~/nixos', follow = true, find_command = { '${pkgs.fd}/bin/fd', '--type=file', '--hidden', '--no-ignore', '--exclude', '/assets' } })";
in {
  options.myModules.home-manager.programs.nvf.enable =
    lib.mkEnableOption "nvf configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.nvf.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          binds.hardtime-nvim.enable = false;
          presence.neocord.enable = true;
          filetree.nvimTree.enable = true;

          # nvim-tree's own auto-open only fires on VimEnter, checking the
          # buffer nvim was started with. Opening nvim bare drops you on the
          # alpha buffer, so that check never sees a real file and nvim-tree
          # stays closed - even after picking a file from the dashboard
          # (e.g. via the "Config bearbeiten" button). Open nvim-tree
          # ourselves once the alpha buffer is left for a real one.
          luaConfigPost = ''
            vim.api.nvim_create_autocmd("FileType", {
              pattern = "alpha",
              callback = function(args)
                vim.api.nvim_create_autocmd("BufWinLeave", {
                  buffer = args.buf,
                  once = true,
                  callback = function()
                    -- defer past the in-flight buffer switch: opening a split
                    -- from inside BufWinLeave races the pending :edit and can
                    -- bounce focus back to the (about to be replaced) buffer
                    vim.schedule(function()
                      require("nvim-tree.api").tree.toggle({ focus = false })
                    end)
                  end,
                })
              end,
            })
          '';

          theme = {
            enable = true;
            name = "rose-pine";
            style = "main";
            transparent = true;
          };

          options = {
            expandtab = true;
            tabstop = 2;
            shiftwidth = 2;
            number = true;
            relativenumber = false;
            ignorecase = true;
            smartcase = true;
            mouse = "a";
            hlsearch = true;
            incsearch = true;
            swapfile = false;
            termguicolors = true;
          };

          clipboard = {
            enable = true;
            registers = "unnamedplus";
            providers.wl-copy.enable = pkgs.stdenv.hostPlatform.isLinux;
          };

          # UI / QoL
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          dashboard.alpha = {
            enable = true;
            theme = null;
            layout = [
              {
                type = "padding";
                val = 4;
              }
              {
                type = "text";
                val = [
                  "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
                  "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
                  "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
                  "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
                  "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
                  "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
                ];
                opts = {
                  position = "center";
                  hl = "String";
                };
              }
              {
                type = "padding";
                val = 2;
              }
              {
                type = "group";
                val = [
                  {
                    type = "button";
                    val = " Neue Datei";
                    on_press = lib.generators.mkLuaInline "function() vim.cmd('ene | startinsert') end";
                    opts = {
                      position = "center";
                      shortcut = "e";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "e"
                        ":ene <BAR> startinsert <CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                  {
                    type = "button";
                    val = "󰱽 Datei suchen";
                    on_press = lib.generators.mkLuaInline "function() require('telescope.builtin').find_files() end";
                    opts = {
                      position = "center";
                      shortcut = "f";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "f"
                        ":lua require('telescope.builtin').find_files()<CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                  {
                    type = "button";
                    val = "󱝩 Wort suchen";
                    on_press = lib.generators.mkLuaInline "function() require('telescope.builtin').live_grep() end";
                    opts = {
                      position = "center";
                      shortcut = "w";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "w"
                        ":lua require('telescope.builtin').live_grep()<CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                  {
                    type = "button";
                    val = "󱑍 Zuletzt geöffnet";
                    on_press = lib.generators.mkLuaInline "function() require('telescope.builtin').oldfiles() end";
                    opts = {
                      position = "center";
                      shortcut = "r";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "r"
                        ":lua require('telescope.builtin').oldfiles()<CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                  {
                    type = "button";
                    val = " Config bearbeiten";
                    on_press = lib.generators.mkLuaInline "function() ${configFindFiles} end";
                    opts = {
                      position = "center";
                      shortcut = "c";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "c"
                        ":lua ${configFindFiles}<CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                  {
                    type = "button";
                    val = " Beenden";
                    on_press = lib.generators.mkLuaInline "function() vim.cmd('qa') end";
                    opts = {
                      position = "center";
                      shortcut = "q";
                      cursor = 25;
                      width = 50;
                      align_shortcut = "right";
                      hl = "Type";
                      hl_shortcut = "Keyword";
                      keymap = [
                        "n"
                        "q"
                        ":qa<CR>"
                        {
                          noremap = true;
                          silent = true;
                          nowait = true;
                        }
                      ];
                    };
                  }
                ];
                opts = {spacing = 1;};
              }
              {
                type = "padding";
                val = 2;
              }
              {
                type = "text";
                val = lib.generators.mkLuaInline "os.date('%A, %d.%m.%Y  •  %H:%M')";
                opts = {
                  position = "center";
                  hl = "Comment";
                };
              }
            ];
            opts = {
              margin = 5;
            };
          };

          visuals = {
            nvim-web-devicons.enable = true;
            indent-blankline.enable = true;
            fidget-nvim.enable = true;
          };

          binds.whichKey.enable = true;
          autopairs.nvim-autopairs.enable = true;

          comments.comment-nvim.enable = true;
          notes.todo-comments.enable = true;

          # Navigation / Telescope setup (Global default includes hidden/ignored files)
          telescope = {
            enable = true;
            setupOpts = {
              pickers = {
                find_files = {
                  find_command = [
                    "${pkgs.fd}/bin/fd"
                    "--type=file"
                    "--hidden"
                    "--no-ignore"
                  ];
                };
              };
            };
          };

          git.gitsigns.enable = true;
          autocomplete.nvim-cmp.enable = true;

          lsp = {
            enable = true;
            lightbulb.enable = true;
            mappings.format = null;
          };
          languages = {
            enableTreesitter = true;
            enableFormat = true;
            nix = {
              enable = true;
              lsp.servers = ["nixd"];
              format.type = ["alejandra"];
            };
            python = {
              enable = true;
              lsp.servers = ["pyrefly"];
            };
            markdown.enable = true;
            bash.enable = true;
          };

          keymaps = [
            {
              key = "<leader>lf";
              mode = ["n" "v"];
              action = "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
              desc = "Format file";
            }
            {
              key = "<leader>bd";
              action = ":bdelete<CR>";
              mode = "n";
              silent = true;
              desc = "Buffer/Datei schliessen";
            }
            {
              key = "<F4>";
              action = ":bdelete<CR>";
              mode = "n";
              silent = true;
              desc = "Buffer mit F4 schliessen";
            }
            {
              key = "<leader>ff";
              mode = "n";
              action = "<cmd>lua require('telescope.builtin').find_files({ hidden = false, no_ignore = false, find_command = { '${pkgs.fd}/bin/fd', '--type=file' } })<CR>";
              desc = "Datei suchen (ohne versteckte Dateien)";
            }
            {
              key = "<leader>fh";
              mode = "n";
              action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
              desc = "Datei suchen (inkl. versteckte Dateien)";
            }
            {
              key = "<leader>rk";
              mode = "n";
              action = "<cmd>lua vim.cmd('resize ' .. math.floor(vim.api.nvim_win_get_height(0) * 1.15))<CR>";
              silent = true;
              desc = "Fenster hoeher (15%)";
            }
            {
              key = "<leader>rj";
              mode = "n";
              action = "<cmd>lua vim.cmd('resize ' .. math.floor(vim.api.nvim_win_get_height(0) * 0.85))<CR>";
              silent = true;
              desc = "Fenster niedriger (15%)";
            }
            {
              key = "<leader>rl";
              mode = "n";
              action = "<cmd>lua vim.cmd('vertical resize ' .. math.floor(vim.api.nvim_win_get_width(0) * 1.15))<CR>";
              silent = true;
              desc = "Fenster breiter (15%)";
            }
            {
              key = "<leader>rh";
              mode = "n";
              action = "<cmd>lua vim.cmd('vertical resize ' .. math.floor(vim.api.nvim_win_get_width(0) * 0.85))<CR>";
              silent = true;
              desc = "Fenster schmaler (15%)";
            }
          ];
        };
      };
    };
  };
}
