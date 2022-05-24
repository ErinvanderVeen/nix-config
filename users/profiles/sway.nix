{ pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    systemdIntegration = true;
  };
}
