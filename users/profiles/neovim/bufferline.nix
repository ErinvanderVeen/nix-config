{
  programs.nixvim = {
    maps = {
      normalVisualOp."<Tab>" = {
        silent = true;
        action = "<cmd>BufferLineCycleNext<cr>";
      };
      normalVisualOp."<S-Tab>" = {
        silent = true;
        action = "<cmd>BufferLineCyclePrev<cr>";
      };
    };

    plugins = {
      bufferline = {
        enable = true;
        alwaysShowBufferline = true;
        diagnostics = "nvim_lsp";
        separatorStyle = "slant";
        showBufferCloseIcons = true;
        showBufferIcons = true;
        showCloseIcon = true;
      };
    };
  };
}
