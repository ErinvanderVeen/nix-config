{ pkgs, ... }:
{
  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    changeDirWidgetOptions = [ "--preview 'exa -l {}'" ];
    defaultOptions = [ "--preview 'bat {}'" ];
    fileWidgetOptions = [ "--preview 'bat {}'" ];
    historyWidgetOptions = [ "--tac" "--exact" ];
  };
}
