{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.myModules.home-manager.programs.starship.enable {
    programs = {
      starship = {
        enable = true;
        enableFishIntegration = true;

        settings = {
          add_newline = false;
          format = "$cmd_duration $directory$git_branch\n  $character";
          fill = {
            symbol = "-";
            style = "fg:7";
          };
          character = {
            success_symbol = "[ ](bold fg:2)";
            error_symbol = "[ ](bold fg:1)";
          };
          package = {
            disabled = true;
          };
          git_branch = {
            style = "bg: 5";
            symbol = "󰘬";
            truncation_length = 12;
            truncation_symbol = "";
            format = " [](bold fg:5)[$symbol $branch(:$remote_branch)](fg:0 bg:5)[ ](bold fg:5)";
          };
          git_commit = {
            commit_hash_length = 4;
            tag_symbol = " ";
          };
          git_state = {
            format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
            cherry_pick = "[🍒 PICKING](bold 1)";
          };
          git_status = {
            conflicted = " 🏳 ";
            ahead = " 🏎💨 ";
            behind = " 😰 ";
            diverged = " 😵 ";
            untracked = " 🤷 ‍";
            stashed = " 📦 ";
            modified = " 📝 ";
            staged = "[++\\($count\\)](2)";
            renamed = " ✍️ ";
            deleted = " 🗑 ";
          };
          hostname = {
            ssh_only = false;
            format = "[•$hostname](bg:1 bold fg:0)[](bold fg:1)";
            trim_at = ".companyname.com";
            disabled = false;
          };
          line_break = {
            disabled = false;
          };
          memory_usage = {
            disabled = true;
            threshold = -1;
            symbol = " ";
            style = "bold dimmed 2";
          };
          time = {
            disabled = true;
            format = "🕙[\\[ $time \\]]($style) ";
            time_format = "%T";
          };
          username = {
            style_user = "bold bg:2 fg:0";
            style_root = "1 bold";
            format = "[](bold fg:0)[$user]($style)";
            disabled = false;
            show_always = true;
          };
          directory = {
            home_symbol = " ";
            read_only = "  ";
            style = "bg:4 fg:0";
            truncation_length = 2;
            truncation_symbol = ".../";
            format = "[](bold fg:4)[󰉋 → $path]($style)[](bold fg:4)";
            substitutions = {
              Desktop = "  ";
              Documents = "  ";
              Downloads = "  ";
              Music = " 󰎈 ";
              Pictures = "  ";
              Videos = "  ";
              GitHub = " 󰊤 ";
            };
          };
          cmd_duration = {
            min_time = 0;
            format = "[](bold fg:3)[󰪢 $duration](bold bg:3 fg:0)[](bold fg:3)";
          };
        };
      };
    };

    xdg.configFile."starship(lambda).toml".source = ./_files/starship/lambda.toml;
  };
}
