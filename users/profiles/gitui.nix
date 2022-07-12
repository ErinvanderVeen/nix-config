{ pkgs, ... }:
{
  home.shellAliases = {
    gui = "gitui";
  };

  programs.gitui = {
    enable = true;
  };
}
