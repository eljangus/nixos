{
  config,
  lib,
  pkgs,
  ...
}: let
  jsonFormat = pkgs.formats.json {};

  schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

  otherConfigs = {
    nitch-like = {
      schema = schema;
      logo = {
        type = "auto";
        width = 1;
        height = 1;
        padding = {
          top = 0;
          left = 1;
        };
      };
      display = {
        separator = " ";
      };
      modules = [
        "break"
        "break"
        {
          key = "╭───────────╮";
          keyColor = "1;1";
          type = "custom";
        }
        {
          key = "{#39}│ {#31}  {#39}User   {#39}│";
          keyColor = "31;1";
          outputColor = "31;1";
          type = "title";
          format = "{user-name}";
        }
        {
          key = "{#39}│ {#32}󰇅  {#39}Hname  {#39}│";
          keyColor = "32;1";
          outputColor = "32;1";
          type = "title";
          format = "{host-name}";
        }
        {
          key = "{#39}│ {#33}{icon}  {#39}Distro {#39}│";
          keyColor = "33;1";
          outputColor = "33;1";
          type = "os";
          format = "{3}";
        }
        {
          key = "{#39}│ {#34}󰅐  {#39}Uptime {#39}│";
          keyColor = "34;1";
          outputColor = "34;1";
          type = "uptime";
          format = "{2}h {3}m";
        }
        {
          type = "command";
          key = "{#39}│ {#35}󰃭  {#39}OS Age {#39}│";
          keyColor = "35;1";
          outputColor = "35;1";
          text = "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days";
        }
        {
          key = "{#39}│ {#36}  {#39}Kernel {#39}│";
          keyColor = "36;1";
          outputColor = "36;1";
          type = "kernel";
          format = "{1} {2}";
        }
        {
          key = "{#39}│ {#31}  {#39}Pkgs   {#39}│";
          keyColor = "31;1";
          outputColor = "31;1";
          type = "packages";
        }
        {
          key = "{#39}│ {#32}󰇄  {#39}DE     {#39}│";
          keyColor = "32;1";
          outputColor = "32;1";
          type = "de";
          format = "{2}";
        }
        {
          key = "{#39}│ {#33}󰖲  {#39}WM     {#39}│";
          keyColor = "33;1";
          outputColor = "33;1";
          type = "wm";
          format = "{1} {5}";
        }
        {
          key = "{#39}│ {#34}  {#39}Term   {#39}│";
          keyColor = "34;1";
          outputColor = "34;1";
          type = "terminal";
          format = "{1} {6}";
        }
        {
          key = "{#39}│ {#35}  {#39}Shell  {#39}│";
          keyColor = "35;1";
          outputColor = "35;1";
          type = "shell";
          format = "{1} {4}";
        }
        {
          key = "{#39}│ {#36}  {#39}Memory {#39}│";
          keyColor = "36;1";
          outputColor = "36;1";
          type = "memory";
          format = "{1}  {2}";
        }
        {
          key = "├───────────┤";
          keyColor = "1;1";
          type = "custom";
        }
        {
          key = "{#39}│ {#39}  {#39}colors {#39}│";
          keyColor = "1;1";
          type = "colors";
          symbol = "circle";
        }
        {
          key = "╰───────────╯";
          keyColor = "1;1";
          type = "custom";
        }
        "break"
        "break"
      ];
    };

    Schlosser = {
      schema = schema;
      logo = {
        type = "auto";
        width = 1;
        height = 1;
        padding = {
          top = 0;
          left = 1;
        };
      };
      display = {
        separator = "  󰨐  ";
      };
      modules = [
        "break"
        "break"
        "break"
        {
          keyColor = "31;1";
          outputColor = "31;1";
          type = "title";
          format = "{user-name} 󱄅 {host-name}";
        }
        "break"
        {
          key = "{icon} Distro  ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "os";
          format = "{3}";
        }
        {
          key = "󰅐 Uptime  ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "uptime";
          format = "{2}h {3}m";
        }
        {
          type = "command";
          key = "󰃭 OS Age  ";
          keyColor = "34;1";
          outputColor = "1;1";
          text = "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days";
        }
        {
          key = " Kernel  ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "kernel";
          format = "{1} {2}";
        }
        {
          key = " Packages";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "packages";
        }
        {
          key = "󰇄 DE      ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "de";
          format = "{2}";
        }
        {
          key = "󰖲 WM      ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "wm";
          format = "{1} {5}";
        }
        {
          key = " Terminal";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "terminal";
          format = "{1} {6}";
        }
        {
          key = " Shell   ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "shell";
          format = "{1} {4}";
        }
        {
          key = " Memory  ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "memory";
          format = "{1}  {2}";
        }
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
        "break"
        "break"
        "break"
      ];
    };

    kitty = {
      schema = schema;
      logo = {
        type = "file";
        source = "~/.config/fastfetch/other-configs/kitty/cat.txt";
      };
      display = {
        constants = [
          ". "
        ];
        key = {
          width = 11;
        };
      };
      modules = [
        {
          type = "title";
          format = "{user-name-colored}{#light_red}@{host-name-colored} {#}{cwd}";
        }
        {
          type = "colors";
          key = "Colors";
          symbol = "circle";
          keyColor = "cyan";
        }
        {
          type = "os";
          key = "Distro";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "Kernel";
          keyColor = "green";
        }
        {
          type = "uptime";
          key = "Uptime";
          keyColor = "yellow";
        }
        {
          type = "disk";
          key = "OS Age";
          folders = "/";
          format = "{create-time:10} [{days} days]";
          keyColor = "blue";
        }
        {
          type = "packages";
          key = "Packages";
          keyColor = "magenta";
        }
        {
          type = "shell";
          key = "Shell";
          keyColor = "cyan";
        }
        {
          type = "wm";
          key = "Desktop";
          keyColor = "red";
        }
      ];
    };

    frieren = {
      display = {
        separator = " ➜  ";
      };
      logo = {
        height = 20;
        padding = {
          left = 0;
          top = 1;
        };
        source = "~/.config/fastfetch/other-configs/frieren/frieren.png";
        type = "kitty-direct";
        width = 26;
      };
      modules = [
        "break"
        {
          key = "OS   ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "title";
        }
        {
          key = " ├  ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "os";
        }
        {
          key = " ├  ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "kernel";
        }
        {
          key = " ├ 󰏖 ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "packages";
        }
        {
          key = " ├  ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "terminal";
        }
        {
          key = " └  ";
          keyColor = "cyan";
          outputColor = "cyan";
          type = "shell";
        }
        "break"
        {
          key = "WM   ";
          keyColor = "blue";
          outputColor = "blue";
          type = "wm";
        }
        {
          key = " ├  ";
          keyColor = "blue";
          outputColor = "blue";
          text = "polybar -v | head -n 1";
          type = "command";
        }
        {
          key = " ├ 󰏒 ";
          keyColor = "blue";
          outputColor = "blue";
          text = "noctalia --version";
          type = "command";
        }
        {
          key = " ├  ";
          keyColor = "blue";
          outputColor = "blue";
          text = "dms version | cut -d'+' -f1";
          type = "command";
        }
        {
          key = " ├  ";
          keyColor = "blue";
          outputColor = "blue";
          text = "caelestia --version | awk '/caelestia-shell/ {printf \"%s v%s\\n\",$1,$2; exit}'";
          type = "command";
        }
        {
          key = " ├ 󰉼 ";
          keyColor = "blue";
          outputColor = "blue";
          type = "wmtheme";
        }
        {
          key = " ├ 󰀻 ";
          keyColor = "blue";
          outputColor = "blue";
          type = "icons";
        }
        {
          key = " ├  ";
          keyColor = "blue";
          outputColor = "blue";
          type = "cursor";
        }
        {
          key = " └  ";
          keyColor = "blue";
          outputColor = "blue";
          type = "terminalfont";
        }
        "break"
        {
          format = "{5} {2}";
          key = "HW   ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "host";
        }
        {
          key = " ├  ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "cpu";
        }
        {
          key = " ├ 󰢮 ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "gpu";
        }
        {
          key = " ├  ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "memory";
        }
        {
          key = " ├ 󰋊 ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "disk";
        }
        {
          format = "{width}x{height} @ {refresh-rate} Hz";
          key = " └  ";
          keyColor = "dim_blue";
          outputColor = "dim_blue";
          type = "monitor";
        }
        "break"
        {
          key = "   Uptime   ";
          type = "uptime";
        }
      ];
    };

    bunnyfetch = {
      schema = schema;
      logo = {
        source = "~/.config/fastfetch/other-configs/bunnyfetch/bunnyascii.txt";
        width = 1;
        height = 1;
        color = {
          "1" = "magenta";
        };
        padding = {
          top = 0;
          left = 1;
        };
      };
      display = {
        separator = "    ";
        percent = {
          type = [
            "num"
            "bar"
            "bar-monochrome"
          ];
        };
        bar = {
          char = {
            elapsed = "●";
            total = "○";
          };
          border = null;
          width = 18;
        };
      };
      modules = [
        {
          keyColor = "35;1";
          outputColor = "35;1";
          type = "title";
          format = "✿ {user-name}@{host-name} ✿";
        }
        {
          keyColor = "34;1";
          outputColor = "34;1";
          type = "custom";
          format = "✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦";
        }
        {
          key = "{icon} Burrow OS       ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "os";
          format = "{3}";
        }
        {
          key = "󰅐 Hoptime         ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "uptime";
          format = "{2}h {3}m";
        }
        {
          key = " Warren kernel   ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "kernel";
          format = "{1} {2}";
        }
        {
          key = " Carrot stash    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "packages";
        }
        {
          key = "󰇄 Cozy den        ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "de";
          format = "{2}";
        }
        {
          key = "󰖲 Blank Burrow    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "wm";
          format = "{1} {5}";
        }
        {
          key = " Whisker Terminal";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "terminal";
          format = "{1} {6}";
        }
        {
          key = " Burrow shell    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "shell";
          format = "{1} {4}";
        }
        {
          key = " Bunny brains    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "cpu";
          format = "{1} ({4} paws)";
        }
        {
          key = " Fluffy Level    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "memory";
          format = "{4} ({1} / {2})";
        }
        {
          key = "󰋊 Burrow space    ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "disk";
          folders = "/";
          format = "{13} ({1} / {2})";
        }
        {
          key = " Nibble note     ";
          keyColor = "34;1";
          outputColor = "1;1";
          type = "custom";
          format = "✿ thumpthump~, bunny is awake ✿";
        }
        {
          keyColor = "34;1";
          outputColor = "34;1";
          type = "custom";
          format = "✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦ ✦";
        }
        "break"
        {
          outputColor = "35;1";
          type = "custom";
          format = "♥ ♥ ♥ ♥ ♥ ♥ ♥ ♥";
        }
        {
          type = "colors";
          symbol = "circle";
        }
        {
          outputColor = "35;1";
          type = "custom";
          format = "✿ thumpthump~ have a fluffy day ✿";
        }
      ];
    };
  };
in {
  options.myModules.home-manager.programs.fastfetch.enable =
    lib.mkEnableOption "fastfetch configuration" // {default = true;};

  config = lib.mkIf config.myModules.home-manager.programs.fastfetch.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        schema = schema;
        logo = {
          source = "~/.config/fastfetch/nitch.txt";
          type = "none";
          width = 1;
          position = "top";
          height = 1;
          padding = {
            top = 0;
            left = 0;
          };
        };
        display = {
          separator = " ";
        };
        modules = [
          {
            key = "   _  ___      ____  ____\n  / |/ (_)_ __/ __ \\/ __/\n /    / /\\ \\ / /_/ /\\ \\  \n/_/|_/_//_\\_\\\\____/___/  ";
            keyColor = "34;1";
            type = "custom";
          }
          "break"
          {
            key = "  ╭───────────╮";
            keyColor = "1;1";
            type = "custom";
          }
          {
            key = "  {#39}│ {#31}  {#39}user   {#39}│";
            keyColor = "31;1";
            outputColor = "31;1";
            type = "title";
            format = "{user-name}";
          }
          {
            key = "  {#39}│ {#33}  {#39}hname  {#39}│";
            keyColor = "33;1";
            outputColor = "33;1";
            type = "title";
            format = "{host-name}";
          }
          {
            key = "  {#39}│ {#32}󰻀  {#39}distro {#39}│";
            keyColor = "32;1";
            outputColor = "32;1";
            type = "os";
            format = "{3}";
          }
          {
            key = "  {#39}│ {#36}󰌢  {#39}kernel {#39}│";
            keyColor = "36;1";
            outputColor = "36;1";
            type = "kernel";
            format = "{1} {2}";
          }
          {
            key = "  {#39}│ {#34}󰅐  {#39}uptime {#39}│";
            keyColor = "34;1";
            outputColor = "34;1";
            type = "uptime";
            format = "{2}h {3}m";
          }
          {
            key = "  {#39}│ {#35}  {#39}shell  {#39}│";
            keyColor = "35;1";
            outputColor = "35;1";
            type = "shell";
            format = "{1}";
          }
          {
            key = "  {#39}│ {#31}󰏖  {#39}pkgs   {#39}│";
            keyColor = "31;1";
            outputColor = "31;1";
            type = "packages";
          }
          {
            key = "  {#39}│ {#33}󰍛  {#39}memory {#39}│";
            keyColor = "33;1";
            outputColor = "33;1";
            type = "memory";
            format = "{1} | {2}";
          }
          {
            key = "  ├───────────┤";
            keyColor = "1;1";
            type = "custom";
          }
          {
            key = "  {#39}│ {#39}  {#39}colors {#39}│";
            keyColor = "1;1";
            type = "colors";
            symbol = "circle";
          }
          {
            key = "  ╰───────────╯";
            keyColor = "1;1";
            type = "custom";
          }
        ];
      };
    };

    xdg.configFile =
      {
        "fastfetch/nitch.txt".source = ./_files/fastfetch/nitch.txt;
        "fastfetch/other-configs/kitty/cat.txt".source = ./_files/fastfetch/other-configs/kitty/cat.txt;
        "fastfetch/other-configs/frieren/frieren.png".source = ./_files/fastfetch/other-configs/frieren/frieren.png;
        "fastfetch/other-configs/bunnyfetch/bunnyascii.txt".source = ./_files/fastfetch/other-configs/bunnyfetch/bunnyascii.txt;
      }
      // lib.mapAttrs' (
        name: settings:
          lib.nameValuePair "fastfetch/other-configs/${name}/config.jsonc" {
            source = jsonFormat.generate "fastfetch-${name}.json" settings;
          }
      )
      otherConfigs;
  };
}
