{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
  isDwm = !isDarwin && osConfig.myModules.desktop == "dwm";
  theme =
    if isDarwin
    then {
      mode = "system";
      light = "Rosé Pine Dawn";
      dark = "Rosé Pine";
    }
    else if lib.elem osConfig.myModules.desktop osConfig.myModules.noctaliaDesktops
    then {
      mode = "system";
      light = "Noctalia Light Transparent";
      dark = "Noctalia Dark Transparent";
    }
    else if isDwm
    then {
      mode = "dark";
      light = "Tokyo Night Light";
      dark = "Tokyo Night Moon";
    }
    else {
      mode = "system";
      light = "One Light";
      dark = "One Dark";
    };
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
          "discord-presence"
        ]
        ++ lib.optionals isDarwin [
          "rose-pine-theme"
          "rose-pine-icons"
          "rose-pine-theme-blur"
        ]
        ++ lib.optionals isDwm ["tokyo-night"];
      userSettings =
        {
          "window_decorations" = "server";
          "edit_predictions" = {
            "provider" = "none";
          };
          "format_on_save" = "off";
          "buffer_font_family" = "Maple Mono NF";
          "vim_mode" = true;
          "relative_line_numbers" = "enabled";
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
              "language_servers" = ["nixd" "discord_presence"];
              "formatter" = {
                "external" = {
                  "command" = "alejandra";
                  "arguments" = [];
                };
              };
            };
            "Python" = {
              "language_servers" = ["pyrefly" "discord_presence"];
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
            "discord_presence" = {
              "initialization_options" = {
                "application_id" = "1263505205522337886";
                "base_icons_url" = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons";

                "state" = "Working on {filename}";
                "details" = "In {workspace}";
                "large_image" = "{base_icons_url}/{language:lo}.png";
                "large_text" = "{language:u}";
                "small_image" = "{base_icons_url}/zed.png";
                "small_text" = "Zed";

                "idle" = {
                  "timeout" = 300;
                  "action" = "change_activity";
                  "state" = "Idling";
                  "details" = "In Zed";
                  "large_image" = "{base_icons_url}/zed.png";
                  "large_text" = "Zed";
                  "small_image" = "{base_icons_url}/idle.png";
                  "small_text" = "Idle";
                };

                "git_integration" = true;

                "languages" = {
                  "nix" = {
                    "state" = "Nixxing it so hard in {filename} rn";
                    "details" = "Working on a Nix project";
                  };
                  "python" = {
                    "state" = "Pythoning it so hard in {filename} rn";
                    "details" = "Working on a Python project";
                  };
                };
              };
            };
            "nixd" = {
              "binary" = {
                "path" = "nixd";
              };
            };
          };
          "agent" = {
            "dock" = "right";
          };
          "theme" =
            {
              "mode" = theme.mode;
              "light" = theme.light;
              "dark" = theme.dark;
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
