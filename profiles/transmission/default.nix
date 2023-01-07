{ pkgs, ... }:
{
  services.transmission = {
    enable = true;
    group = "jellyfin";
    openFirewall = true;
    settings = {
      download-dir = "/var/media/series";
      incomplete-dir = "/var/media/incomplete";
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
      rpc-host-whitelist-enabled = false;
    };
    openRPCPort = true;
  };
}
