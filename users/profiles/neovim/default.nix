{ pkgs, ... }:
{

  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./floaterm.nix
    ./lang
    ./lsp.nix
    ./luasnip.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  home.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      wl-clipboard
    ];

    colorschemes.tokyonight = {
      enable = true;
      lualineBold = true;
      style = "storm";
      terminalColors = true;
    };

    maps = {
      terminal."<esc>" = {
        silent = true;
        action = "<c-\\><c-n>";
      };
    };

    globals = {
      mapleader = " ";
    };

    options = {
      mouse = "a";
      termguicolors = true;
      number = true;
      relativenumber = true;
      spelllang = "en_gb";
      completeopt = "menu,menuone,noselect";
    };

    plugins = {
      comment-nvim = {
        enable = true;
        mappings.basic = true;
      };
      mark-radar.enable = true;
      neogit.enable = true;
    };
  };
}
