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
    megapixels # Camera
  ];

  hardware.sensor.iio.enable = true;
}
