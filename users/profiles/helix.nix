{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "rose_pine";
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
        };
        idle-timeout = 0;
        lsp = {
          display-messages = true;
        };
      };
    };
  };
}
