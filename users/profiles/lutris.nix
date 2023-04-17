{ pkgs, ... }: {
  home.packages = with pkgs; [
    lutris
    # For installing an managing proton
    protonup

    # For some packages
    wineWowPackages.stable
    winetricks
    mono
    dxvk
    wget
    appimage-run
  ];
}
