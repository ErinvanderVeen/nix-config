{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      discord
    ];
  };

  xdg.configFile."discord/settings.json".text = ''
    {
      "BACKGROUND_COLOR": "#202225",
      "SKIP_HOST_UPDATE": true
    }
  '';
}
