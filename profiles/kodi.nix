{ pkgs, ... }:
let
  kodi-wayland = pkgs.kodi.passthru.withPackages (kodiPkgs: with kodiPkgs; [
    jellyfin
    youtube
  ]);
in
{
  services.cage.user = "nixos";
  services.cage.program = "${kodi-wayland}/bin/kodi-standalone";
  services.cage.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 8080 9090 ];
    allowedUDPPorts = [ 8080 9090 ];
  };
}
