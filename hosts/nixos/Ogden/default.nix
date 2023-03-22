{ suites, lib, pkgs, ... }:
{
  imports = [
  ] ++ suites.base
  ++ suites.erin;

  services.xserver.desktopManager.phosh = {
    user = "erin";
  };

  mobile.beautification = {
    silentBoot = lib.mkDefault true;
    splash = lib.mkDefault true;
  };

  services.xserver.desktopManager.phosh = {
    enable = true;
    group = "users";
  };

  programs.calls.enable = true;

  environment.systemPackages = with pkgs; [
    chatty # IM and SMS
    epiphany # Web browser
    gnome-console # Terminal
    gnome-secrets
    gnome.eog
    gnome.file-roller
    gnome.geary
    gnome.gnome-calculator
    gnome.gnome-calendar
    gnome.gnome-clocks
    gnome.gnome-contacts
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-system-monitor
    gnome.gnome-weather
    gnome.nautilus
    gnome.totem
    megapixels # Camera
  ];

  hardware.sensor.iio.enable = true;
}
