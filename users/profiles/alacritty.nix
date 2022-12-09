{ pkgs, ... }:
{
  home.packages = [ pkgs.nerdfonts ];
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "FiraCode Nerd Font Mono ";
      font.size = 10;
      colors = {
        primary = {
          background = "0x0F111A";
          foreground = "0xA6ACCD";
        };
        cursor = {
          text = "0x000000";
          cursor = "0xFFFF00";
        };
        vi_mode_cursor = {
          text = "0x000000";
          cursor = "0xFFFF00";
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "0x1F2233";
          background = "0xffffff";
        };
        normal = {
          black = "0x000000";
          red = "0xDC6068";
          green = "0xABCF76";
          yellow = "0xE6B455";
          blue = "0x6E98EB";
          magenta = "0xB480D6";
          cyan = "0x71C6E7";
          white = "0xffffff";
        };
        bright = {
          black = "0x000000";
          red = "0xF07178";
          green = "0xC3E88D";
          yellow = "0xFFCB6B";
          blue = "0x82AAFF";
          magenta = "0xC792EA";
          cyan = "0x89DDFF";
          white = "0xffffff";
        };
        hints = {
          start = {
            foreground = "0x36d0e0";
            background = "0x262a33";
          };
          end = {
            foreground = "0x36d0e0";
            background = "0x262a33";
          };
        };
      };
    };
  };
}
