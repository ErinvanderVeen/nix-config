# This module contains all packages without much/any configuration.
{ pkgs, ... }: {
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

      baobab
      element-desktop
      keepassxc
      libreoffice-fresh
      pinta
      signal-desktop
      spotify
      translate-shell
      transmission-gtk
    ];
    keyboard = null;
  };

  programs.firefox = {
    enable = true;
  };
}
