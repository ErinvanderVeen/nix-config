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
      translate-shell
      transmission-gtk
      spotify
      helvum
      baobab
    ];
    keyboard = null;
  };

  programs.firefox = {
    enable = true;
  };
}
