{ pkgs, ... }:
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      fzf
      ripgrep
    ];

    maps = {
      normalVisualOp."<leader>ff" = {
        silent = true;
        action = "<cmd>lua require('telescope').extensions.frecency.frecency()<cr>";
        description = "Frecency";
      };
      normalVisualOp."<leader>fg" = {
        silent = true;
        action = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
        description = "Grep";
      };
    };

    plugins = {
      telescope = {
        enable = true;
        extensions = {
          frecency = {
            enable = true;
            defaultWorkspace = "CWD";
          };
        };
      };
    };
  };
}
