{
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  options.myModules.home-manager.programs.zed.enable =
    lib.mkEnableOption "zed configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.zed.enable {
    home.packages = with pkgs; [
      nixd
      pyrefly
      ruff
      alejandra
      mcp-nixos
    ];

    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      mutableUserSettings = false;
      mutableUserKeymaps = false;
      mutableUserTasks = false;
      extensions =
        [
          "nix"
          "toml"
          "pyrefly"
          "catppuccin"
          "catppuccin-blur"
          "catppuccin-icons"
        ]
        ++ lib.optionals isDarwin [
          "rose-pine-theme"
          "rose-pine-icons"
          "rose-pine-theme-blur"
        ];
      userSettings =
        {
          "edit_predictions" = {
            "provider" = "none";
          };
          "format_on_save" = "off";
          "buffer_font_family" = "Maple Mono NF";
          "vim_mode" = true;
          "session" = {
            "trust_all_worktrees" = true;
          };
          "buffer_font_weight" = 300.0;
          "ui_font_weight" = 300.0;
          "ui_font_family" = "Maple Mono NF";
          "line_height" = "comfortable";
          "project_panel" = {
            "dock" = "left";
            "entry_spacing" = "comfortable";
            "hide_gitignore" = true;
            "default_width" = 200.0;
          };
          "outline_panel" = {
            "dock" = "left";
          };
          "collaboration_panel" = {
            "dock" = "left";
          };
          "git_panel" = {
            "dock" = "left";
          };
          "telemetry" = {
            "diagnostics" = false;
            "metrics" = false;
          };
          "ui_font_size" = 20.0;
          "buffer_font_size" = 18.0;
          "languages" = {
            "YAML" = {
              "format_on_save" = "off";
            };
            "Nix" = {
              "language_servers" = ["nixd"];
              "formatter" = {
                "external" = {
                  "command" = "alejandra";
                  "arguments" = [];
                };
              };
            };
            "Python" = {
              "language_servers" = ["pyrefly"];
              "formatter" = {
                "external" = {
                  "command" = "ruff";
                  "arguments" = ["format" "-"];
                };
              };
            };
          };
          "minimap" = {
            "show" = "always";
          };
          "lsp" = {
            "nixd" = {
              "binary" = {
                "path" = "nixd";
              };
            };
          };
          "agent" = {
            "dock" = "right";
          };
          "theme" = {
            "mode" = "system";
            "light" = "Noctalia Light Transparent";
            "dark" = "Noctalia Dark Transparent";
            "agent_servers" = {
              "claude-acp" = {
                "type" = "registry";
              };
              "mcp-nixos" = {
                "type" = "registry";
              };
            };
          };
        }
        // lib.optionalAttrs isDarwin {
          "ui_font_size" = 17.0;
          "buffer_font_size" = 15.0;
        };
    };
  };
}
