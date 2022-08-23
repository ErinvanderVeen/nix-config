{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };

  home.packages = with pkgs; [
    # SPELLING
    aspell
    aspellDicts.en
    aspellDicts.nl
    aspellDicts.nb
    aspellDicts.sv
  ];
}
