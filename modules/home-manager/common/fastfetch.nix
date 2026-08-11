{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.fastfetch.enable {
    programs.fastfetch = {
      enable = true;

      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
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

    xdg.configFile = {
      "fastfetch/nitch.txt".source = ./_files/fastfetch/nitch.txt;
      "fastfetch/other-configs".source = ./_files/fastfetch/other-configs;
    };
  };
}
