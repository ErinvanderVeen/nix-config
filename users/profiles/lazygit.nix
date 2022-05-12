{ pkgs, ... }:
{
  home.shellAliases = {
    lg = "lazygit";
  };

  programs.lazygit = {
    enable = true;
    settings = {
      quitOnTopLevelReturn = true;
    };
  };
}
