{ pkgs, ... }:
{
  home.packages = [ pkgs.nerdfonts ];
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "Fira Mono Nerd Font";
      font.size = 10;
      colors = {
        primary = {
          background = "0x262a33";
          foreground = "0xbbc2cf";
        };
        cursor = {
          text = "0xbbc2cf";
          cursor = "0x443d30";
        };
        vi_mode_cursor = {
          text = "0xbbc2cf";
          cursor = "0x443d30";
        };
        line_indicator = {
          foreground = "None";
          background = "None";
        };
        selection = {
          text = "0xe0def4";
          background = "0x2e323c";
        };
        normal = {
          black = "0x000000";
          red = "0xe95678";
          green = "0xafd700";
          yellow = "0xfac661";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x36d0e0";
          white = "0xffffff";
        };
        bright = {
          black = "0x000000";
          red = "0xe95678";
          green = "0xafd700";
          yellow = "0xfac661";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x36d0e0";
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
