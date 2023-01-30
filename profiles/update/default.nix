# This module is reponsible for automatically keeping our NixOS machines up to date
{ pkgs, lib, ... }:
{
  system.autoUpgrade = {
    enable = true;
    dates = "Sun";
    randomizedDelaySec = "10min";
    # Override for our servers
    allowReboot = lib.mkDefault false;
    flags = [ "--update-input" "nixpkgs" "--no-write-lock-file" ];
    flake = "github:ErinvanderVeen/nix-config";
  };
}
