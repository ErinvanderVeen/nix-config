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

  home.stateVersion = "22.11";
}
