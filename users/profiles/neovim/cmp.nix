{
  programs.nixvim = {
    plugins = {
      nvim-cmp = {
        enable = true;
        completion = {
          completeopt = "menu,menuone,noselect";
          keyword_length = 2;
        };

        auto_enable_sources = true;

        sources = [
          { name = "buffer"; }
          { name = "conventionalcommits"; }
          { name = "dap"; }
          { name = "fuzzy_path"; }
          { name = "git"; }
          { name = "luasnip"; }
          { name = "nvim_lsp_document_symbol"; }
          { name = "nvim_lsp_signature_help"; }
          { name = "nvim_lsp"; }
          { name = "spell"; }
          { name = "treesitter"; }
        ];

        snippet.expand = ''
          function(args)
              require('luasnip').lsp_expand(args.body)
          end
        '';

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require('luasnip').expand_or_jumpable() then
                  require('luasnip').expand_or_jump()
                else
                  fallback()
                end
              end
            '';
          };
          "<S-Tab>" = {
            modes = [ "i" "s" ];
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
          };
        };
      };
    };
  };
}
