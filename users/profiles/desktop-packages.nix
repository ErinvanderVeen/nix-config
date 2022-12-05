# This module contains all packages without much/any configuration.
{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # SPELLING
      aspell
      aspellDicts.en
      aspellDicts.nl
      aspellDicts.sv
      hunspell
      hunspellDicts.en_GB-ise
      hunspellDicts.sv_SE
      hunspellDicts.nl_NL

      keepassxc
      libreoffice-fresh
      signal-desktop
      translate-shell
      trash-cli
      transmission-gtk
      tor-browser-bundle-bin
      element-desktop
      spotify
      helvum
      baobab

      # For google meet (FF works, but camera quality is greatly reduced)
      ungoogled-chromium
    ];
    keyboard = null;
  };

  programs.firefox = {
    enable = true;
  };
}
