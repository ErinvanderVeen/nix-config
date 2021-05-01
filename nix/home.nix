{ pkgs, lib, config, ... }:

let
  foreground = "#fafafa";
  background = "#282A36";
  selection_foreground = "#fafafa";
  selection_background = "#313440";

  url_color = "#5fafff";

  color0 = "#282c34";
  color8 = "#282c34";

  # White
  color7 = "#ffffff";
  color15 = "#ffffff";

  # Red
  color1 = "#ff6059";
  color9 = "#ff6059";

  # Green
  color2 = "#5fff87";
  color10 = "#5fff87";

  # Blue
  color4 = "#5fafff";
  color12 = "#5fafff";

  # Yellow
  color3 = "#ffff87";
  color11 = "#ffff87";

  # Magenta
  color5 = "#af87ff";
  color13 = "#af87ff";

  # Cyan
  color6 = "#5fafff";
  color14 = "#5fafff";

  # Cursor colors
  cursor = "#f8f8f2";

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

    overlays = [
      (
        import (
          builtins.fetchTarball {
            url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
          }
        )
      )
    ];
  };

  home.packages = with pkgs; [
    aerc # Email client

    # SPELLING
    aspell
    aspellDicts.en
    aspellDicts.nl
    aspellDicts.sv

    betterdiscordctl # Manage Better discord, allows setting custom themes, like dracula
    cabal-install # Haskell project tool
    cmus # Music
    discord # UNFREE
    dtrx # Extract any archive
    evince # pdf viewer
    exa # ls alternative
    fd # find alternative
    font-awesome # for i3-status-rs
    ghc # Haskell compiler
    glab # CLI for GitLab
    gnome-mpv # video player
    gnupg
    haskell-language-server # Haskell language server
    hlint # Haskell linter
    krita # for digital art
    libreoffice-fresh # Office package
    lua # needed for neovim
    lutris # Non-steam games and windows games
    maim # To create screenshots
    minecraft # UNFREE
    myxer # alternative to pavucontrol
    nix-index # Allow searching for files in nixpkgs
    nvimpager # Use NVIM as a pager (man, less, etc)
    nodejs-slim # Needed for coc
    obs-studio # streaming, recording and virtual camera
    powerline-fonts # for powerline-go
    qtpass # pass gui
    ranger # Terminal fm
    ripgrep # used for fzf, general replacement for grep
    rnix-lsp # nix language server
    rustfmt # Formatter for rust
    skype # UNFREE (Needed for work)
    translate-shell # translate sentences in the terminal
    trash-cli # Alternative to rm that moves to trash
    watson # cli time tracker
    xclip # to copy screenshots to clipboard
    youtube-dl # download youtube videos
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    CLEAN_HOME = "/home/erin/clean";
    PATH = "$PATH:$CLEAN_HOME/bin:$CLEAN_HOME/lib/exe";
    PAGER = "nvimpager";
  };

  home.keyboard = null;

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

  programs = {
    home-manager = {
      enable = true;
      path = "…";
    };

    htop = {
      enable = true;
      showProgramPath = false;
      highlightBaseName = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
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
            block = "watson";
            show_time = true;
            state_path = "/home/erin/.config/watson/state";
            interval = 60;
          }
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "used";
            unit = "GB";
            interval = 600;
            warning = 80.0;
            alert = 90.0;
            format = " {used}/{total} {unit}";
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{Mup}%";
            format_swap = "{SUp}%";
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

    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "erin@erinvanderveen.nl";
      userName = "Erin van der Veen";
      delta.enable = true;
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

    password-store = {
      enable = true;
      settings = { PASSWORD_STORE_DIR = "Nextcloud/Passwords"; };
    };

    browserpass = {
      enable = true;
      browsers = [ "firefox" ];
    };

    powerline-go = {
      enable = true;
      modules = [ "host" "ssh" "cwd" "gitlite" "nix-shell" ];
    };

    bash = {
      enable = true;
      enableVteIntegration = true;
      shellOptions = [
        "histappend"
        "checkwinsize"
        "extglob"
        "globstar"
        "checkjobs"
        "autocd"
        "dirspell"
      ];
      initExtra = ''
        function cd {
          builtin cd "$@" && exa -l
        }
        set -o vi
      '';
      shellAliases = {
        icat = "kitty +kitten icat";
        la = "exa -al --git";
        ll = "exa -l --git";
        ls = "exa";
        con = "home-manager edit";
        update = "sudo nix-channel --update";
        upgrade = "sudo nixos-rebuild switch && home-manager switch";
        grep = "grep --color";
        cls = "grep -rn --include '*.dcl' --include '*.icl'";
        vfzf = "vim \"$(fzf)\"";
        debian = "sudo systemd-nspawn -D ~/Debian/";
        r = "ranger";
        clean-tags = "steam-run cloogletags -a -c -d ~/clean/lib -o ~/clean/lib/tags";
        project-tags = "steam-run cloogletags -a -c -d . -o .tags";
      };
    };

    feh.enable = true;

    firefox = {
      enable = true;
      profiles = {
        myprofile = {
          isDefault = true;
          settings = { "general.smoothScroll" = false; };
        };
      };
    };

    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withPython3 = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins // custom-vim-plugins; [
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
          plugin = dracula-vim;
          config = ''
            set packpath+=${pkgs.vimPlugins.dracula-vim}/share/vim-plugins/
            packadd! dracula-vim
            colorscheme dracula
            set termguicolors
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
            autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
            " lsp servers
            lua << EOF
              local nvim_lsp = require'lspconfig'
              -- function to attach completion when setting up lsp
              local on_attach = function(client)
                  require'completion'.on_attach(client)
              end
              -- Language servers
              nvim_lsp.rnix.setup{}
              nvim_lsp.rust_analyzer.setup{}
              nvim_lsp.hls.setup{}
              -- Enable diagnostics
              vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = true,
                  signs = true,
                  update_in_insert = true,
                }
              )
            EOF
            autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
            \ lua require'lsp_extensions'.inlay_hints{ prefix = "■ ", highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
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
        set cc=120
        set clipboard=unnamedplus
        set dir=~/.swp
        set listchars=nbsp:¬,tab:→\ ,extends:»,precedes:«,trail:·,space:·
        set list
        set mouse=a
        set nu rnu
        set path+=**
        set tw=119
        set tabstop=4
        set shiftwidth=4
        set noexpandtab
        hi NormalFloat guibg=${background}
        autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
        set completeopt=menuone,noinsert,noselect
        autocmd BufEnter * set title
      '';
      extraPackages = with pkgs; [ rust-analyzer ];
    };

    #ssh = {
    #  enable = true;
    #  matchBlocks = [
    #      "cleanbuild" = {
    #	      hostname = "cleanbuild.cs.ru.nl";
    #	      user = "erin";
    #	      identityFile = "~/.ssh/buildserver";
    #	      localforward
    #      }
    #  ];

    #};

    kitty = {
      enable = true;
      font.name = "Ubuntu Mono";
      font.package = pkgs.ubuntu_font_family;
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
        font_size = "14";
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
        "${pkgs.rofi}/bin/rofi -modi window,drun,ssh,combi -show combi -font \\" Ubuntu 12\\" -icon-theme \\" Paper\\" -show-icons" '';
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
          fonts = [ "FontAwesome" "Ubuntu" ];
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
            "${modifier}+k" = "focus right";
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
    nextcloud-client = { enable = true; };

    password-store-sync = { enable = true; };

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
          font = "Ubuntu";
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
