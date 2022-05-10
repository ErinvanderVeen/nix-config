{ pkgs, ... }:
{
  programs.skim = {
    enable = true;
    enableBashIntegration = true;
    changeDirWidgetOptions = [ "--preview 'exa -l {}'" ];
    defaultOptions = [ "--preview 'bat {}'" ];
    fileWidgetOptions = [ "--preview 'bat {}'" ];
    historyWidgetOptions = [ "--tac" "--exact" ];
  };
}
