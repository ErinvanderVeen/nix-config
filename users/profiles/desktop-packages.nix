# This module contains all packages without much/any configuration.
{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # SPELLING
      aspell
      aspellDicts.en
      aspellDicts.nl
      aspellDicts.nb
      aspellDicts.sv
      keepassxc
      libreoffice-fresh
      signal-desktop
      translate-shell
      trash-cli
      transmission-gtk
      tor-browser-bundle-bin
    ];
    keyboard = null;
  };

  programs.firefox = {
    enable = true;
  };
}
