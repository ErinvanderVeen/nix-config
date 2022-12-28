{
  programs.nixvim = {
    maps = {
      normalVisualOp."<leader>e" = {
        silent = true;
        action = "<cmd>NvimTreeFindFileToggle<cr>";
        description = "Tree";
      };
    };

    plugins = {
      nvim-tree = {
        enable = true;
        diagnostics.enable = true;
        git.enable = true;
        hijackNetrw = true;
        disableNetrw = true;
      };
    };
  };
}
