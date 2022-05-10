{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "onedark";
      editor = {
        line-number = "relative";
      };
    };
  };
}
