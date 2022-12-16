{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      slack
      # For google meet (FF works, but camera quality is greatly reduced)
      chromium
      zoom-us
      citrix_workspace
    ];
  };
}
