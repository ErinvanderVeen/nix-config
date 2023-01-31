# This module contains the home manager configuration that is only intended for the "kyjan" user.
{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      dolphin-emu
    ];
  };
}
