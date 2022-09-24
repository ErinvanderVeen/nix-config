{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gimp
      krita
      scribus
    ];
  };
}
