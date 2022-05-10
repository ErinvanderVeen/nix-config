{ pkgs, ... }:
{
  home.packages = with pkgs; [
    polymc
    jdk17
    glfw
  ];
}
