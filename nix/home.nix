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

  custom-vim-plugins = pkgs.callPackage ./custom-vim-plugins.nix { };
in {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    cmus # Music
    betterdiscordctl # Manage Better discord, allows setting custom themes, like dracula
    discord
    evince # pdf viewer
    exa # ls alternative
    fd # find alternative
    fzf # fuzzy finder
    font-awesome # for i3-status-rs
    gnupg
    glab # CLI for GitLab
    krita # for digital art
    libreoffice-fresh # Office package
    maim # To create screenshots
    minecraft
    nodejs-slim # Needed for coc
    powerline-fonts # for powerline-go
    powerline-go # statusline for bash
    skype
    translate-shell # translate sentences in the terminal
    watson # cli time tracker
    xclip # to copy screenshots to clipboard
    youtube-dl # download youtube videos
  ];

  home.sessionVariables = {
    CLEAN_HOME = "~/clean";
    PATH = "$PATH:$CLEAN_HOME/bin:$CLEAN_HOME/lib/exe";
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
          { block = "sound"; }
          {
            block = "time";
            interval = 60;
            format = "%A %d/%m %R";
            locale = "se_NO";
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
        vfzf = "vim $(fzf)";
        kfzf = "kak $(fzf)";
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

    kakoune = {
      enable = true;
      config = {
        alignWithTabs = true;
        colorScheme = "dracula";
        indentWidth = 0;
        numberLines = {
          enable = true;
          highlightCursor = true;
          relative = true;
        };
        showMatching = true;
        showWhitespace  = {
          enable = true;
        };
        tabStop = 4;
        ui = {
          enableMouse = true;
          assistant = "cat";
          setTitle = true;
        };
        wrapLines = {
          enable = true;
          indent = true;
          marker = "⏎";
        };
      };
      plugins = with pkgs.kakounePlugins; [
        fzf-kak
        sleuth-kak
        powerline-kak
        quickscope-kak
        active-window-kak
        kakoune-state-save
        kak-lsp
      ];
      extraConfig = ''
        # Enable kak-lsp
        eval %sh{kak-lsp --kakoune -s $kak_session}
        lsp-enable
        # Highlight trailing
        add-highlighter global/ regex \h+$ 0:Error
        # Use ,y to copy to system keyboard
        map global user y '<a-|>xsel -i -b<ret>'
        # Clean
        source ~/Projects/clean-kak/clean.kak
        '';
    };

    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins // custom-vim-plugins; [
        airline
        haskell-vim
        idris2-vim
        vim-clean
        vim-css-color
        vim-gitgutter
        vim-nix
        vim-toml
        {
          plugin = rust-vim;
          config = ''
            let g:rustfmt_autosave = 1
          '';
        }
        {
          plugin = coc-nvim;
          config = ''
            nmap <silent> [g <Plug>(coc-diagnostic-prev)
            nmap <silent> ]g <Plug>(coc-diagnostic-next)
            nmap <silent> gd <Plug>(coc-definition)
            nmap <silent> gy <Plug>(coc-type-definition)
            nmap <silent> gi <Plug>(coc-implementation)
            nmap <silent> gr <Plug>(coc-references)
            nmap <leader>ac  <Plug>(coc-codeaction)
            nmap <leader>qf  <Plug>(coc-fix-current)
            nmap <leader>rn  <Plug>(coc-rename)
            nmap <leader>f   <Plug>(coc-format)
            hi CocFloating ctermbg=0
          '';
        }
        coc-rust-analyzer
        fzf-vim
      ];
      extraConfig = ''
        set cc=120
        set clipboard=unnamedplus
        set dir=~/.swp
        set listchars=nbsp:¬,tab:❥\ ,extends:»,precedes:«,trail:•
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
      '';
      extraPackages = with pkgs; [ rust-analyzer ];
    };

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
        window_padding_width = "20";
      };
      keybindings = {
        "ctrl+shift+n" = "new_os_window_with_cwd";
        "ctrl+shift+t" = "new_tab_with_cwd";
      };
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
      focus.mouseWarping = false;
      menu = ''
        "${pkgs.rofi}/bin/rofi -modi window,drun,ssh,combi -show combi -font \\"Ubuntu 12\\" -icon-theme \\"Paper\\" -show-icons"'';
      modifier = "Mod4";
      bars = [{
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
      }];
      startup = [{ command = "autorandr --change"; } { command = "feh --bg-scale /etc/nixos/background_image.jpg"; }];
      keybindings =
        let modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+s" =
            "exec --no-startup-id maim --select | xclip -selection clipboard -t image/png";
        };
    };
  };

  xsession.pointerCursor = {
    package = pkgs.numix-cursor-theme;
    name = "Numix-Cursor";
  };

  services = {
    #nextcloud-client = { enable = true; };

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

  xdg.configFile."kak/colors/dracula-transparent.kak".text = ''
    colorscheme dracula

    set-face global Default %opt{foreground}
    set-face global LineNumbers %opt{dimmed_background}
    set-face global LineNumberCursor "%opt{foreground}+b"
    set-face global LineNumbersWrapped "%opt{dimmed_background}+i"
    set-face global Information %opt{yellow}
    set-face global StatusLine %opt{foreground}
    set-face global StatusLineInfo %opt{purple}
    set-face global StatusLineValue %opt{orange}
    set-face global BufferPadding %opt{dimmed_background}
    set-face global Whitespace %opt{dimmed_background}
    '';

  xdg.configFile."kak/colors/dracula.kak".text = ''
    declare-option str black 'rgb:282a36'
    declare-option str gray 'rgb:44475a'
    declare-option str white 'rgb:f8f8f2'
    declare-option str blue 'rgb:6272a4'
    declare-option str cyan 'rgb:8be9fd'
    declare-option str green 'rgb:50fa7b'
    declare-option str orange 'rgb:ffb86c'
    declare-option str pink 'rgb:ff79c6'
    declare-option str purple 'rgb:bd93f9'
    declare-option str red 'rgb:ff5555'
    declare-option str yellow 'rgb:f1fa8c'

    declare-option str background %opt{black}
    declare-option str dimmed_background %opt{gray}
    declare-option str foreground %opt{white}

    # For code
    set-face global value "%opt{green}"
    set-face global type "%opt{purple}"
    set-face global variable "%opt{red}"
    set-face global module "%opt{red}"
    set-face global function "%opt{red}"
    set-face global string "%opt{yellow}"
    set-face global keyword "%opt{cyan}"
    set-face global operator "%opt{orange}"
    set-face global attribute "%opt{pink}"
    set-face global comment "%opt{blue}+i"
    set-face global meta "%opt{red}"
    set-face global builtin "%opt{white}+b"

    # For markup
    set-face global title "%opt{red}"
    set-face global header "%opt{orange}"
    set-face global bold "%opt{pink}"
    set-face global italic "%opt{purple}"
    set-face global mono "%opt{green}"
    set-face global block "%opt{cyan}"
    set-face global link "%opt{green}"
    set-face global bullet "%opt{green}"
    set-face global list "%opt{white}"

    # Builtin faces
    set-face global Default "%opt{white},%opt{black}"
    set-face global PrimarySelection "%opt{black},%opt{pink}"
    set-face global SecondarySelection "%opt{black},%opt{purple}"
    set-face global PrimaryCursor "%opt{black},%opt{cyan}"
    set-face global SecondaryCursor "%opt{black},%opt{orange}"
    set-face global PrimaryCursorEol "%opt{black},%opt{cyan}"
    set-face global SecondaryCursorEol "%opt{black},%opt{orange}"
    set-face global LineNumbers "%opt{gray},%opt{black}"
    set-face global LineNumberCursor "%opt{white},%opt{gray}+b"
    set-face global LineNumbersWrapped "%opt{gray},%opt{black}+i"
    set-face global MenuForeground "%opt{blue},%opt{white}+b"
    set-face global MenuBackground "%opt{white},%opt{blue}"
    set-face global MenuInfo "%opt{cyan},%opt{blue}"
    set-face global Information "%opt{yellow},%opt{gray}"
    set-face global Error "%opt{black},%opt{red}"
    set-face global StatusLine "%opt{white},%opt{black}"
    set-face global StatusLineMode "%opt{black},%opt{green}"
    set-face global StatusLineInfo "%opt{purple},%opt{black}"
    set-face global StatusLineValue "%opt{orange},%opt{black}"
    set-face global StatusCursor "%opt{white},%opt{blue}"
    set-face global Prompt "%opt{black},%opt{green}"
    set-face global MatchingChar "%opt{black},%opt{blue}"
    set-face global Whitespace "%opt{gray},%opt{black}+f"
    set-face global WrapMarker Whitespace
    set-face global BufferPadding "%opt{gray},%opt{black}"
    '';

  # CoC is configured using its own configuratio file
  xdg.configFile."nvim/coc-settings.json".text = ''
    {
      "rust-analyzer.server.path": "${pkgs.rust-analyzer}/bin/rust-analyzer",

      "languageserver": {
        "haskell": {
          "command": "haskell-language-server-wrapper",
          "args": [
            "--lsp"
          ],
          "rootPatterns": [
            "*.cabal",
            ".stack.yaml",
            ".hie-bios",
            "BUILD.bazel",
            "cabal.config",
            "package.yaml"
          ],
          "filetypes": [
            "hs",
            "lhs",
            "haskell"
          ],
          "initializationOptions": {
            "languageServerHaskell": {
              "hlintOn": true,
              "maxNumberOfProblems": 10,
              "completionSnippetsOn": true
            }
          }
        }
      }

    }
  '';
}
