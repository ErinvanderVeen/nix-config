{ pkgs, ... }:
{
  home.packages = [ pkgs.nerdfonts ];
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = pkgs.writeShellScript "startup.sh" ''
          #!/usr/bin/env bash
          ZJ_SESSIONS=$(zellij list-sessions)
          NO_SESSIONS=$(echo "''${ZJ_SESSIONS}" | wc -l)

          if [ "''${NO_SESSIONS}" -ge 1 ]; then
              CHOICES="''${ZJ_SESSIONS}"$'\nnew-session'
              CHOICE="$(echo "''${CHOICES}" | sk)"
              if [ "''${CHOICE}" = "new-session" ]; then
                  zellij
              else
                  zellij attach "''${CHOICE}"
              fi
          else
             zellij
          fi
        '';
      };
      font.normal.family = "Fira Mono Nerd Font";
      font.size = 10;
      colors = {
        primary = {
          background = "0x191724";
          foreground = "0xe0def4";
        };
        cursor = {
          text = "0xe0def4";
          cursor = "0x524f67";
        };
        vi_mode_cursor = {
          text = "0xe0def4";
          cursor = "0x524f67";
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "0xe0def4";
          background = "0x403d52";
        };
        normal = {
          black = "0x26233a";
          red = "0xeb6f92";
          green = "0x31748f";
          yellow = "0xf6c177";
          blue = "0x9ccfd8";
          magenta = "0xc4a7e7";
          cyan = "0xebbcba";
          white = "0xe0def4";
        };
        bright = {
          black = "0x6e6a86";
          red = "0xeb6f92";
          green = "0x31748f";
          yellow = "0xf6c177";
          blue = "0x9ccfd8";
          magenta = "0xc4a7e7";
          cyan = "0xebbcba";
          white = "0xe0def4";
        };
        hints = {
          start = {
            foreground = "#908caa";
            background = "#1f1d2e";
          };
          end = {
            foreground = "#6e6a86";
            background = "#1f1d2e";
          };
        };
      };
    };
  };
}
