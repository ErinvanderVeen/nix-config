{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # SPELLING
    aspell
    aspellDicts.en
    aspellDicts.nl
    aspellDicts.nb
    aspellDicts.sv
  ];
}
