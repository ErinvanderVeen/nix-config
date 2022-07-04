{ pkgs, ... }:
{
  accounts.email.accounts."personal" = {
    address = "erin@erinvanderveen.nl";
    himalaya = {
      enable = true;
    };
    imap = {
      host = "imap.transip.email";
      tls.enable = true;
      port = 993;
    };
    primary = true;
    realName = "Erin van der Veen";
    smtp = {
      host = "smtp.transip.email";
      tls.enable = true;
      port = 465;
    };
    userName = "erin@erinvanderveen.nl";
    passwordCommand = "${pkgs.libsecret}/bin/secret-tool lookup account erin@erinvanderveen.nl";
  };

  programs.himalaya = {
    enable = true;
    settings = {
      default-page-size = 50;
    };
  };

  home.shellAliases = {
    mail = "nvim -c \"Himalaya\"";
  };

  programs.neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.himalaya-vim;
      config = ''
        let g:himalaya_mailbox_picker = 'telescope'
        let g:himalaya_telescope_preview_enabled = 0
        lua <<EOF
          local wk = require("which-key")
          wk.register{
            ["<leader>"] = {
              m = {
                name = "+mail",
                m = { "<cmd>Himalaya<CR>", "Open Mailbox" },
              },
            },
          }
        EOF
      '';
    }
  ];
}
