{ pkgs, ... }:
{
  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    changeDirWidgetOptions = [ "--preview 'exa -l {}'" ];
    fileWidgetOptions = [ "--preview 'bat {}'" ];
    historyWidgetOptions = [ "--exact" ];
  };
}
