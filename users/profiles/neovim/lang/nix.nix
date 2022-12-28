{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      nix.enable = true;
      lsp = {
        enable = true;
        servers.rnix-lsp.enable = true;
      };
    };
  };
}
