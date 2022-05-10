{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      foreground #979eab
      background #282c34

      color0 #282c34
      color1 #e06c75
      color2 #98c379
      color3 #e5c07b
      color4 #61afef
      color5 #be5046
      color6 #56b6c2
      color7 #979eab
      color8 #393e48
      color9 #d19a66
      color10 #56b6c2
      color11 #e5c07b
      color12 #61afef
      color13 #be5046
      color14 #56b6c2
      color15 #abb2bf

      # Tab Bar

      active_tab_foreground   #282c34
      active_tab_background   #979eab
      inactive_tab_foreground #abb2bf
      inactive_tab_background #282c34
    '';
    font = {
      package = pkgs.nerdfonts;
      name = "Hack Nerd Font";
      size = 11;
    };

    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+h" = "previous_tab";
    };
  };
}
