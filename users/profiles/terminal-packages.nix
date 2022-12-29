# This module contains all terminal packages without any configuration.
{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
    ];
  };
}
