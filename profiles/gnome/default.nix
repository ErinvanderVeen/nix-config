{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-console
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      gnome-characters
    ]);

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator # Sys tray
    blur-my-shell # Blur when opening menu
    gsconnect # Connect to phone
    syncthing-indicator
    vitals # Computer status
    task-widget # Tasks
    dash-to-dock # Pin dock
  ];

  # gsconnect required ports
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1716;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1716;
        to = 1764;
      }
    ];
  };
}
