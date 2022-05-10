{ pkgs, ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      quitOnTopLevelReturn = true;
    };
  };
}
