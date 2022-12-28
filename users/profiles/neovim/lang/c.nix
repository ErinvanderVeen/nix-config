{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers.clangd.enable = true;
      };
    };
  };
}
