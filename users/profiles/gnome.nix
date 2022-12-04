{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-todo
  ];

  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "alacritty";
      name = "Alacritty";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "gsconnect@andyholmes.github.io"
        "pomodoro@arun.codito.in"
        "syncthing@gnome.2nv2u.com"
      ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "Alacritty.desktop"
        "org.gnome.Geary.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Photos.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
