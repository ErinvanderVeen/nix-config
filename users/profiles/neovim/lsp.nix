{
  programs.nixvim = {
    maps = {
      normalVisualOp."<leader>lf" = {
        silent = true;
        action = "<cmd>Lspsaga lsp_finder<cr>";
        description = "LSP finder";
      };
    };

    extraConfigLua = ''
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })
    '';

    plugins = {
      lsp = {
        enable = true;
      };
      lsp-lines.enable = true;
      lspsaga.enable = true;
    };
  };
}
