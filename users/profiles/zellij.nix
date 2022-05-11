{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "rose-pine";
      themes.rose-pine = {
        fg = 8;
        bg = 0;
        black = 234;
        gray = 0;
        red = 3;
        green = 3;
        yellow = 0;
        blue = 0;
        magenta = 0;
        cyan = 0;
        white = 5;
        orange = 1;
      };
    };
  };
}
