{ pkgs, ... }:
{
  services.transmission = {
    enable = true;
    group = "jellyfin";
    openFirewall = true;
    settings = {
      download-dir = "/var/media/series";
      incomplete-dir = "/var/media/incomplete";
    };
  };
}
