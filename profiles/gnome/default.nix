{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator # Sys tray
    gnomeExtensions.blur-my-shell # Blur when opening menu
    gnomeExtensions.gsconnect # Connect to phone
    gnomeExtensions.syncthing-indicator
    gnomeExtensions.vitals # Computer status
    gnomeExtensions.task-widget # Tasks
    gnomeExtensions.dash-to-dock # Pin dock
  ];

  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

  # gsconnect required ports
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1716; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1716; to = 1764; }
    ];
  };
}
