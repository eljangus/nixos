{
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
in {
  options.myModules.home-manager.programs.zed.enable =
    lib.mkEnableOption "zed configuration"
    // {
      default = true;
    };

  config = lib.mkIf config.myModules.home-manager.programs.zed.enable {
    home.packages = with pkgs; [
      nixd
      pyrefly
      alejandra
      mcp-nixos
    ];

    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      mutableUserSettings = false;
      mutableUserKeymaps = false;
      mutableUserTasks = false;
      extensions = ["nix" "rose-pine-theme"];
      userSettings = {
        "edit_predictions" = {
          "provider" = "none";
        };
        "format_on_save" = "off";
        "font_family" = "JetBrainsMono Nerd Font Mono";
        "vim_mode" = true;
        "session" = {
          "trust_all_worktrees" = true;
        };
        "font_weight" = 300.0;
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
        "ui_font_size" = 19.0;
        "font_size" = 18.0;
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
        "agent_servers" = {
          "claude-acp" = {
            "type" = "registry";
          };
          "mcp-nixos" = {
            "type" = "registry";
          };
        };
        "theme" = {
          "mode" = "system";
          "light" = "Rosé Pine Dawn";
          "dark" = "Rosé Pine";
        };
      };
    };
  };
}
