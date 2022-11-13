{ pkgs, ... }:
{
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 25565; to = 25565; }
    ];
  };
}
