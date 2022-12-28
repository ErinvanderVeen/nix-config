{ pkgs, ... }:
{
  programs.nixvim = {
    extraConfigLua = ''
      vim.env.RUST_SRC_PATH = '${pkgs.rustPlatform.rustLibSrc}'
    '';

    plugins = {
      lsp = {
        enable = true;
        servers.rust-analyzer.enable = true;
      };
    };
  };
}
