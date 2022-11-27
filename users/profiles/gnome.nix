{ pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Rose-Pine";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ ];
      switch-applications-backward = [ ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "gsconnect@andyholmes.github.io"
        "Vitals@CoreCoding.com"
        "shell-volume-mixer@derhofbauer.at"
        "blur-my-shell@aunetx"
        "pomodoro@arun.codito.in"
      ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "hibernate";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Geary.desktop"
        "org.gnome.Calendar.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Photos.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
