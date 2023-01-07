{ pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
