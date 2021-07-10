{ pkgs, lib, config, ... }:

let
  foreground = "#979eab";
  background = "#1f2329";
  selection_foreground = "#5b6268";
  selection_background = "#b3deef";

  url_color = "#61afef";

  color0 = "#282c34";
  color8 = "#393e48";

  # White
  color7 = "#979eab";
  color15 = "#bbc2cf";

  # Red
  color1 = "#e55561";
  color9 = "#8b3434";

  # Green
  color2 = "#8ebd6b";
  color10 = "#5e8d6b";

  # Blue
  color4 = "#4fa6ed";
  color12 = "#0f66ad";

  # Yellow
  color3 = "#e2b86b";
  color11 = "#835d1a";

  # Magenta
  color5 = "#bf68d9";
  color13 = "#7e3992";

  # Cyan
  color6 = "#48b0bd";
  color14 = "#266269";

  # Cursor colors
  cursor = "#cccccc";

  # Tab bar colors
  active_tab_foreground = "#282a36";
  active_tab_background = "#f8f8f2";
  inactive_tab_foreground = "#282a36";
  inactive_tab_background = "#6272a4";

  # Marks
  mark1_foreground = "#282a36";
  mark1_background = "#ff5555";

  custom-vim-plugins = pkgs.callPackage ./custom-vim-plugins.nix {};

in
{
  nixpkgs = {
    config.allowUnfree = true;
  };

  home = {
    packages = with pkgs; [
      # SPELLING
      aspell
      aspellDicts.en
      aspellDicts.nl
      aspellDicts.sv
      cabal-install # Haskell project tool
      cargo # Rust packagemanager, buildsystem, etc
      cmus # Music
      discord # UNFREE
      evince # pdf viewer
      fd # find alternative
      font-awesome # for i3-status-rs
      ghc # Haskell compiler
      glab # CLI for GitLab
      gnome-mpv # video player
      gnome.eog # Image viewer
      gnome.libsecret # lookup secret
      gnupg
      hlint # Haskell linter
      keepassx2 # Keepass
      krita # for digital art
      libnotify # for notify-send
      libreoffice-fresh # Office package
      lutris # Non-steam games and windows games
      maim # To create screenshots
      minecraft # UNFREE
      myxer # alternative to pavucontrol
      nix-index # Allow searching for files in nixpkgs
      nvimpager # Use NVIM as a pager (man, less, etc)
      nodejs-slim # Needed for coc
      obs-studio # streaming, recording and virtual camera
      oh-my-zsh # plugins for zsh
      ormolu # Haskell formatter
      powerline-fonts # for powerline-go
      ripgrep # used for fzf, general replacement for grep
      rust-analyzer # Rust language server
      signal-desktop
      skype # UNFREE (Needed for work)
      teamspeak_client # UNFREE Needed for [OURS] raids
      translate-shell # translate sentences in the terminal
      trash-cli # Alternative to rm that moves to trash
      xclip # to copy screenshots to clipboard
      youtube-dl # download youtube videos
      zsh-prezto # zsh
    ];
    sessionVariables = {
      EDITOR = "nvim";
      CLEAN_HOME = "/home/erin/clean";
      PATH = "$PATH:$CLEAN_HOME/bin:$CLEAN_HOME/lib/exe";
      PAGER = "nvimpager";
    };
    keyboard = null;
  };

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
  };

  accounts.email = {
    accounts = {
      personal = {
        address = "erin@erinvanderveen.nl";
        imap = {
          host = "imap.transip.email";
          port = 993;
          tls.enable = true;
        };
        neomutt = {
          enable = true;
        };
        msmtp.enable = true;
        imapnotify = {
          enable = true;
          boxes = [
            "Inbox"
          ];
          onNotify = "${pkgs.isync}/bin/mbsync -a";
          onNotifyPost = "${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
        };
        mbsync = {
          enable = true;
          create = "maildir";
        };
        passwordCommand = "${pkgs.gnome.libsecret}/bin/secret-tool lookup personal-email password";
        primary = true;
        realName = "Erin van der Veen";
        smtp = {
          host = "smtp.transip.email";
          port = 465;
          tls.enable = true;
        };
        userName = "erin@erinvanderveen.nl";
      };
    };
  };

  programs = {
    autorandr = {
      enable = true;
      profiles = {
        pc = {
          fingerprint = {
            HDMI-0 =
              "00ffffffffffff001e6d205a0bb406000c18010380331d78ea6275a3554fa027125054210800714081c08100818095009040a9c0b300023a801871382d40582c4500fe221100001e000000fd00383d1e530f000a202020202020000000fc0032344d5035350a202020202020000000ff000a20202020202020202020202001ae02031df14a900403011412051f1013230907078301000065030c001000023a801871382d40582c4500fe221100001e011d8018711c1620582c2500fe221100009e011d007251d01e206e285500fe221100001e8c0ad08a20e02d10103e9600fe22110000180000000000000000000000000000000000000000000000000000e6";
            HDMI-1 =
              "00ffffffffffff001e6d205adeb306000c18010380331d78ea6275a3554fa027125054210800714081c08100818095009040a9c0b300023a801871382d40582c4500fe221100001e000000fd00383d1e530f000a202020202020000000fc0032344d5035350a202020202020000000ff000a20202020202020202020202001dc02031df14a900403011412051f1013230907078301000065030c001000023a801871382d40582c4500fe221100001e011d8018711c1620582c2500fe221100009e011d007251d01e206e285500fe221100001e8c0ad08a20e02d10103e9600fe22110000180000000000000000000000000000000000000000000000000000e6";
          };
          config = {
            HDMI-0 = {
              enable = true;
              primary = true;
              position = "0x0";
              mode = "1920x1080";
              rate = "60";
            };
            HDMI-1 = {
              enable = true;
              primary = false;
              position = "1920x0";
              mode = "1920x1080";
              rate = "60";
            };
          };
        };
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    feh.enable = true;

    firefox = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "erin@erinvanderveen.nl";
      userName = "Erin van der Veen";
      ignores = [
        "*~"
        ".tags"
      ];
      extraConfig = {
        init.defaultBranch = "main";
        merge.tool = "nvimdiff";
        pull.rebase = "false";
      };
    };

    home-manager = {
      enable = true;
      path = "…";
    };

    htop = {
      enable = true;
      settings = {
        show_program_path = false;
        highlight_base_name = true;
      };
    };

    i3status-rust = {
      enable = true;
      bars.default = {
        settings = {
          theme = {
            name = "native";
            overrides = {
              critical_bg = "${color1}";
              critical_fg = "${foreground}";
              good_bg = "${color2}";
              good_fg = "${background}";
              idle_bg = "${background}";
              idle_fg = "${foreground}";
              info_bg = "${color4}";
              info_fg = "${foreground}";
              warning_bg = "${color3}";
              warning_fg = "${background}";
            };
          };
          icons = { name = "awesome5"; };
        };
        blocks = [
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "used";
            unit = "GB";
            interval = 600;
            warning = 80.0;
            alert = 90.0;
            format = " {used}/{total}";
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_total_used_percents}";
            format_swap = "{swap_used_percents}";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "load";
            interval = 1;
            format = "{1m}";
          }
          {
            block = "sound";
            on_click = "myxer";
          }
          {
            block = "time";
            interval = 60;
            format = "%A %d/%m %R";
            locale = "sv_SE";
          }
        ];
      };
    };

    kitty = {
      enable = true;
      font.name = "Noto Sans Mono";
      font.package = pkgs.noto-fonts;
      settings = {
        foreground = "${foreground}";
        background = "${background}";
        selection_foreground = "${selection_foreground}";
        selection_background = "${selection_background}";
        url_color = "${url_color}";
        color0 = "${color0}";
        color8 = "${color8}";
        color1 = "${color1}";
        color9 = "${color9}";
        color2 = "${color2}";
        color10 = "${color10}";
        color3 = "${color3}";
        color11 = "${color11}";
        color4 = "${color4}";
        color12 = "${color12}";
        color5 = "${color5}";
        color13 = "${color13}";
        color6 = "${color6}";
        color14 = "${color14}";
        color7 = "${color7}";
        color15 = "${color15}";
        cursor = "${cursor}";
        cursor_text_color = "${background}";
        active_tab_foreground = "${active_tab_foreground}";
        active_tab_background = "${active_tab_background}";
        mark1_foreground = "${mark1_foreground}";
        mark1_background = "${mark1_background}";
        font_size = "12";
        allow_remote_control = true;
      };
      keybindings = {
        "ctrl+shift+n" = "new_os_window_with_cwd";
        "ctrl+shift+t" = "new_tab_with_cwd";
        "ctrl+shift+enter" = "new_window_with_cwd";
        # Windows
        "ctrl+h" = "neighboring_window left";
        "ctrl+l" = "neighboring_window right";
        "ctrl+k" = "neighboring_window up";
        "ctrl+j" = "neighboring_window down";
        "ctrl+shift+l" = "next_tab";
        "ctrl+shift+h" = "previous_tab";
      };
      extraConfig = ''
        enabled_layouts tall:bias=70;
        full_size = 1;
        mirrored = false
      '';
    };

    lazygit.enable = true;

    lf.enable = true;

    mbsync.enable = true;

    msmtp.enable = true;

    neomutt = {
      enable = true;
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins // custom-vim-plugins; [
        vimwiki
        {
          plugin = airline;
          config = ''
            let g:airline#extensions#tabline#enabled = 1
          '';
        }
        haskell-vim
        {
          plugin = vim-clean;
          config = ''
            autocmd BufEnter *.icl,*.dcl set tags=~/clean/lib/tags,.tags
          '';
        }
        vim-css-color
        {
          plugin = gitsigns-nvim; # Git information in vim
          config = ''
            lua require('gitsigns').setup()
          '';
        }
        plenary-nvim # Depedency of gitsigns
        vim-nix
        vim-toml
        vim-highlightedyank
        {
          plugin = onedark-nvim;
          config = ''
            let g:onedark_style = 'darker'
            colorscheme onedark
          '';
        }
        {
          plugin = hop-nvim;
          config = ''
            nmap <leader>hw <cmd>HopWord<CR>
          '';
        }
        {
          plugin = nvim-treesitter;
          config = ''
            lua <<EOF
            require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,
              },
              indent = {
                enable = true,
              },
            }
            EOF
          '';
        }
        {
          plugin = rust-vim;
          config = ''
            let g:rustfmt_autosave = 1
          '';
        }
        {
          plugin = fzf-vim;
          config = ''
            nmap <c-_> :Rg <CR>
          '';
        }
        lsp_extensions-nvim
        {
          plugin = nvim-lspconfig;
          config = ''
            nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
            nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
            nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
            nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
            nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
            nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
            nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
            nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
            nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
            " auto-format
            autocmd BufWritePre *.nix,*.hs lua vim.lsp.buf.formatting_sync(nil, 100)
            " lsp servers
            lua << EOF
              local lspconfig = require'lspconfig'
              -- function to attach completion when setting up lsp
              local on_attach = function(client)
                  require'completion'.on_attach(client)
              end
              -- Language servers
              lspconfig.rnix.setup{}
              lspconfig.rust_analyzer.setup {
                settings = {
                  ["rust-analyzer"] = {
                    ["checkOnSave"] = {
                      ["enabled"] = true,
                        ["command"] = "clippy",
                    },
                  },
                },
              }
              lspconfig.hls.setup{}
              lspconfig.yamlls.setup{}
              -- Enable diagnostics
              vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = true,
                  signs = true,
                  update_in_insert = true,
                }
              )
              -- Example server with hardcoded path
              local configs = require'lspconfig/configs'
              if not lspconfig.example_lsp then
                configs.example_lsp = {
                  default_config = {
                    cmd = {'/home/erin/Projects/clean-lsp/example/wrapper.sh'};
                    filetypes = {'clean'};
                    root_dir = function(fname)
                      return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
                    end;
                    settings = {};
                  };
                }
              end
              lspconfig.example_lsp.setup{}
            EOF
            "autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
            "\ lua require'lsp_extensions'.inlay_hints{ prefix = "■ ", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
          '';
        }
        {
          plugin = completion-nvim;
          config = ''
            autocmd BufEnter * lua require'completion'.on_attach()
            let g:completion_enable_snippet = 'vim-vsnip'
          '';
        }
        vim-vsnip # Snippet plugin
        vim-vsnip-integ # LSP Support for snippets
      ];
      extraConfig = ''
        nmap <leader>y "+y
        vmap <leader>y "+y
        nmap <leader>yy "+yy
        nmap <leader>p "+p
        nmap <leader>P "+P
        vmap <leader>p "+p 
        vmap <leader>P "+P"`"`"
        set cc=120
        set dir=~/.swp
        set list
        set listchars=nbsp:¬,tab:→\ ,extends:»,precedes:«,trail:·,space:·
        set mouse=a
        set nu rnu
        set path+=**
        "set noexpandtab
        "set shiftwidth=4
        "set tabstop=4
        set tw=119
        filetype plugin indent on
        hi NormalFloat guibg=${background}
        autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
        set completeopt=menuone,noinsert,noselect
        autocmd BufEnter * set title
        nnoremap <leader><space> :noh<CR>
        set fillchars=eob:\|,
      '';

      extraPackages = with pkgs; [
        haskell-language-server
        lua # Required for certain plugins
        nixfmt
        rnix-lsp # nix language server
        rustfmt
        yaml-language-server
      ];
    };

    rofi = {
      enable = true;
      pass = { enable = true; };
      colors = {
        window = {
          background = "${background}";
          border = "${color11}";
          separator = "${color11}";
        };
        rows = {
          normal = {
            background = "${background}";
            foreground = "${foreground}";
            backgroundAlt = "${background}";
            highlight = {
              background = "${foreground}";
              foreground = "${background}";
            };
          };
        };
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "top-001" = {
          hostname = "top-001.tilaa.cloud";
          user = "erin";
          identityFile = "~/.ssh/top-001";
          port = 22;
        };
        "top-ci" = {
          hostname = "top-002-ci.tilaa.cloud";
          user = "erin";
          identityFile = "~/.ssh/top-001";
          port = 22;
        };
        "top-cloogle" = {
          hostname = "top-003-cloogle.tilaa.cloud";
          user = "erin";
          identityFile = "~/.ssh/top-001";
          port = 22;
        };
        "top-staging" = {
          hostname = "top-004-staging.tilaa.cloud";
          user = "erin";
          identityFile = "~/.ssh/top-001";
          port = 22;
        };
        "cleanbuild" = {
          hostname = "cleanbuild.cs.ru.nl";
          user = "erin";
          identityFile = "~/.ssh/buildserver";
          port = 22;
          localForwards = [
            {
              bind.port = 8081;
              host = {
                address = "localhost";
                port = 8080;
              };
            }
          ];
        };
        "cleanbuild-macos" = {
          proxyCommand = "ssh cleanbuild nc 10.10.0.11 22";
          user = "build";
        };
        "cleanbuild-linux-arm32" = {
          proxyCommand = "ssh cleanbuild nc 10.10.0.12 22";
          user = "build";
        };
        "cleanbuild-linux-arm64" = {
          proxyCommand = "ssh cleanbuild nc 10.10.0.20 22";
          user = "build";
        };
        "cleanbuild-linux-x64" = {
          proxyCommand = "ssh cleanbuild nc 10.10.0.13 22";
          user = "build";
        };
        "cleanbuild-linux-x86" = {
          proxyCommand = "ssh cleanbuild nc 10.10.0.14 22";
          user = "build";
        };
      };
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autocd = true;
      defaultKeymap = "viins";
      history = {
        expireDuplicatesFirst = true;
      };
      prezto = {
        enable = true;
        editor = {
          dotExpansion = true;
          keymap = "vi";
          promptContext = true;
        };
        terminal = {
          autoTitle = true;
        };
        syntaxHighlighting = {
          highlighters = [
            "main"
            "brackets"
            "pattern"
            "line"
            "cursor"
            "root"
          ];
        };
      };
      oh-my-zsh = {
        enable = false;
        plugins = [
          "git"
          "sudo"
        ];
      };
      shellAliases = {
        clean-tags = "steam-run cloogletags -a -c -d ~/clean/lib -o ~/clean/lib/tags";
        cls = "grep -rni --include '*.dcl' --include '*.icl'";
        con = "home-manager edit";
        debian = "sudo systemd-nspawn -D ~/Debian/";
        grep = "grep --color";
        icat = "kitty +kitten icat";
        lg = "lazygit";
        project-tags = "steam-run cloogletags -a -c -d . -o .tags";
        r = "ranger";
        ssh = "kitty +kitten ssh";
        update = "sudo nix-channel --update";
        upgrade = "sudo nixos-rebuild switch && home-manager switch";
        vfzf = "nvim \"$(fzf)\"";
        # Translation
        sv = "trans -t sv-SE";
        nl = "trans -t nl-NL";
        en = "trans -t en-GB";
      };
    };
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "kitty";
      window = {
        border = 0;
        titlebar = false;
      };
      focus = {
        mouseWarping = false;
        followMouse = false;
      };
      menu = ''
        "${pkgs.rofi}/bin/rofi -modi window,drun,ssh,combi -show combi -font \\" Noto Sans 12\\" -icon-theme \\" Paper\\" -show-icons" '';
      modifier = "Mod4";
      bars = [
        {
          colors = {
            background = "${background}";
            bindingMode = {
              border = "${color1}";
              background = "${color1}";
              text = "${color0}";
            };
            focusedWorkspace = {
              border = "${color3}";
              background = "${color3}";
              text = "${color0}";
            };
            inactiveWorkspace = {
              border = "${background}";
              background = "${background}";
              text = "${foreground}";
            };
          };
          fonts = { names = [ "FontAwesome" "Noto Sans" ]; size = 14.0; };
          statusCommand =
            "i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
      startup = [ { command = "autorandr --change"; } { command = "feh --bg-scale /etc/nixos/background_image.jpg"; } ];
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
          lib.mkOptionDefault {
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move right";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Shift+s" =
              "exec --no-startup-id maim --select | xclip -selection clipboard -t image/png";
          };
    };
    extraConfig = ''
      for_window [ class="Myxer" instance="myxer" ] move position mouse
    '';
  };

  xsession.pointerCursor = {
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
  };

  services = {
    imapnotify.enable = true;

    nextcloud-client = { enable = true; };

    picom = {
      enable = true;
      inactiveDim = "0.2";
      vSync = true;
      extraOptions = ''
        xrender-sync-fence = true;
        glx-no-stencil = true;
      '';
    };

    gnome-keyring = {
      enable = true;
    };

    # Notification daemon
    dunst = {
      enable = true;
      settings = {
        global = {
          alignment = "center";
          bounce_freq = 0;
          corner_radius = 6;
          font = "Noto Sans";
          format = "<b>%s</b>\\n%b";
          geometry = "350x5-25+25";
          horizontal_padding = 8;
          idle_threshold = 120;
          ignore_newline = false;
          indicate_hidden = true;
          line_height = 0;
          markup = "full";
          max_icon_size = 60;
          padding = 8;
          separator_color = "#00000000";
          separator_height = 5;
          show_age_threshold = 30;
          sort = true;
          startup_notification = false;
          sticky_history = true;
          transparency = 0;
          word_wrap = true;
        };
        urgency_low = {
          background = "${color2}";
          foreground = "${background}";
          timeout = 5;
        };
        urgency_normal = {
          background = "${color3}";
          foreground = "${background}";
          timeout = 20;
        };
        urgency_critical = {
          background = "${color1}";
          foreground = "${background}";
          timeout = 0;
        };
      };
    };
  };
}
