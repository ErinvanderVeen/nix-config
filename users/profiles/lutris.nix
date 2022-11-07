{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lutris
    # For installing an managing proton
    protonup
  ];
}
