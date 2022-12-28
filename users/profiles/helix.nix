{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # clipboard
    wl-clipboard

    # Language servers
    rnix-lsp
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "always";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
        };
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            newline = "none";
          };
        };
        indent-guides = {
          render = true;
        };
      };
      keys = {
        normal = {
          "tab" = ":buffer-next";
          "S-tab" = ":buffer-previous";
        };
      };
    };
  };
}
