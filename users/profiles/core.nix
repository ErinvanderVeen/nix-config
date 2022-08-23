{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
    plugins = with pkgs.fishPlugins; [
      (with fzf-fish; { inherit name src; })
      (with done; { inherit name src; })
    ];
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
