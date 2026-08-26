{
  config,
  lib,
  pkgs,
  ...
}: let
  # --no-ignore also lifts fd's built-in .git exclusion (it's implemented as
  # an ignore rule), so it must be excluded explicitly or it floods the
  # picker with .git/objects blobs.
  configFindFiles = "require('telescope.builtin').find_files({ cwd = '~/nixos', follow = true, find_command = { '${pkgs.fd}/bin/fd', '--type=file', '--hidden', '--no-ignore', '--exclude', '.git', '--exclude', '/assets' } })";
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in {
  options.myModules.home-manager.programs.nvf.enable =
    lib.mkEnableOption "nvf configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.nvf.enable {
    home.packages = with pkgs; [
      ripgrep
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
          binds.hardtime-nvim.enable = false;
          presence.neocord.enable = true;

          theme =
            {
              enable = true;
              name = "rose-pine";
              style = "main"; # main means it's universal and switches between light and dark mode, use this if no specific theme is in mind.
              # name = "tokyonight";
              # style = "moon";
              transparent = true;
            }
            // lib.optionalAttrs isDarwin {
              name = "rose-pine";
              style = "main";
              transparent = true;
            };

          options = {
            expandtab = true;
            tabstop = 2;
            shiftwidth = 2;
            number = true;
            relativenumber = true;
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
                    val = " New file";
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
                    val = "󰱽 Find file";
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
                    val = "󱝩 Live grep";
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
                    val = "󱑍 Recent files";
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
                    val = " Edit config";
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
                    val = " Quit";
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
            nvim-cursorline.enable = true;
          };

          # Polished cmdline/messages (Zed-style command palette feel)
          ui.noice.enable = true;

          binds.whichKey = {
            enable = true;
            # Group labels shown in the which-key popup
            register = {
              "<leader>f" = "+Find";
              "<leader>g" = "+Git";
              "<leader>h" = "+Git Hunk";
              "<leader>t" = "+Toggle";
              "<leader>x" = "+Trouble";
              "<leader>l" = "+LSP";
              "<leader>s" = "+Session";
              "<leader>b" = "+Buffer";
              "<leader>r" = "+Resize";
              "<leader><leader>" = "+Swap Buffer";
              "<leader>a" = "Harpoon: mark file";
            };
          };
          autopairs.nvim-autopairs.enable = true;
          mini.bufremove.enable = true;
          mini.move.enable = true;

          # Pin ≤4 files and jump instantly (slots moved to <leader>1-4 to
          # avoid colliding with smart-splits' <C-hjkl> window navigation)
          navigation.harpoon = {
            enable = true;
            mappings = {
              file1 = "<leader>1";
              file2 = "<leader>2";
              file3 = "<leader>3";
              file4 = "<leader>4";
            };
          };

          comments.comment-nvim.enable = true;
          notes.todo-comments.enable = true;

          # File tree, closest equivalent to Zed's project panel
          filetree.neo-tree.enable = true;

          # Navigation / Telescope setup. <leader>ff (nvf default) uses this
          # picker default: respects .gitignore, no dotfiles - the least
          # surprising behaviour. <leader>fa (below) opts into everything.
          telescope = {
            enable = true;
            setupOpts = {
              pickers = {
                find_files = {
                  find_command = [
                    "${pkgs.fd}/bin/fd"
                    "--type=file"
                  ];
                };
              };
            };
            extensions = [
              {
                name = "fzf";
                packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
                setup = {
                  fzf = {
                    fuzzy = true;
                    override_generic_sorter = true;
                    override_file_sorter = true;
                  };
                };
              }
            ];
          };

          git = {
            gitsigns.enable = true;
          };
          utility.diffview-nvim.enable = true;

          # Directional split navigate/resize/swap, tmux/wezterm/kitty-aware.
          # Resize is rebound to <leader>r+hjkl (kept from the old manual
          # bindings) since its Alt+hjkl default collides with mini.move.
          utility.smart-splits = {
            enable = true;
            keymaps = {
              resize_left = "<leader>rh";
              resize_down = "<leader>rj";
              resize_up = "<leader>rk";
              resize_right = "<leader>rl";
            };
          };

          # Jump anywhere on screen in two keystrokes. Note: shadows the
          # native `s`/`S` (substitute char/line) - the standard, accepted
          # trade-off for flash.nvim.
          utility.motion.flash-nvim.enable = true;

          terminal.toggleterm = {
            enable = true;
            lazygit.enable = true;
          };

          session.nvim-session-manager = {
            enable = true;
            setupOpts = {
              autosave_last_session = true;
              # Keep session restore manual (<leader>sl/<leader>slt) so startup
              # always shows the alpha dashboard instead of the last file.
              autoload_mode = "Disabled";
            };
          };

          autocomplete.blink-cmp = {
            enable = true;
            setupOpts.signature.enabled = true;
          };

          lsp = {
            enable = true;
            lightbulb.enable = true;
            lspkind.enable = true;
            inlayHints.enable = true;
            trouble.enable = true;
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

            # Systems (unused for now)
            # rust.enable = true;
            # go.enable = true;
            # clang.enable = true;
            # lua.enable = true;

            # Web dev (unused for now)
            # typescript.enable = true;
            # tsx.enable = true;
            # html.enable = true;
            # css.enable = true;
            # json.enable = true;
          };

          keymaps = [
            {
              key = "<leader>e";
              action = ":Neotree toggle<CR>";
              mode = "n";
              silent = true;
              desc = "Toggle file tree";
            }
            {
              key = "<leader>lf";
              mode = ["n" "v"];
              action = "<cmd>lua require('conform').format({ lsp_format = 'fallback' })<CR>";
              desc = "Format file";
            }
            {
              key = "<leader>bd";
              action = "<cmd>lua require('mini.bufremove').delete(0, false)<CR>";
              mode = "n";
              silent = true;
              desc = "Close buffer";
            }
            {
              key = "<F4>";
              action = "<cmd>lua require('mini.bufremove').delete(0, false)<CR>";
              mode = "n";
              silent = true;
              desc = "Close buffer (F4)";
            }
            {
              key = "<leader>fa";
              mode = "n";
              action = "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true, find_command = { '${pkgs.fd}/bin/fd', '--type=file', '--hidden', '--no-ignore', '--exclude', '.git' } })<CR>";
              desc = "Find files (all, incl. hidden)";
            }
            {
              key = "<leader>gd";
              mode = "n";
              action = "<cmd>lua local v = require('diffview.lib').get_current_view(); vim.cmd(v and 'DiffviewClose' or 'DiffviewOpen')<CR>";
              silent = true;
              desc = "Toggle diffview";
            }
            {
              key = "<Esc>";
              mode = "n";
              action = "<cmd>nohlsearch<CR>";
              silent = true;
              desc = "Clear search highlight";
            }
            {
              key = "<C-s>";
              mode = ["n" "i"];
              action = "<cmd>w<CR>";
              silent = true;
              desc = "Save file";
            }
          ];
        };
      };
    };
  };
}
