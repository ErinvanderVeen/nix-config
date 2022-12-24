# This module contains small pieces of configuration that do not deserve their
# own configuration
{ pkgs, ... }:
{
  # Boot related
  boot.plymouth.enable = true;
}
