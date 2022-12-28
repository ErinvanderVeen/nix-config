{ pkgs, ... }:
{
  programs.nixvim = {
    extraConfigLua = ''
      require("luasnip.loaders.from_vscode").lazy_load()
    '';

    extraPlugins = with pkgs.vimPlugins; [
      luasnip
    ];
  };
}
