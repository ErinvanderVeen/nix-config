{ pkgs, lib, config, ... }:

let
  foreground = "#fafafa";
  background = "#313440";
  selection_foreground = "#fafafa";
  selection_background = "#252834";

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
  custom-packages = pkgs.callPackage ./custom-packages.nix { };

  nur = import (builtins.fetchTarball
    "https://github.com/nix-community/NUR/archive/master.tar.gz");
in {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };

  home.packages = with pkgs // custom-packages; [
    cmus # Music
    betterdiscordctl # Manage Better discord, allows setting custom themes, like dracula
    cg # The Clean code generator
    discord
    exa # ls alternative
    fd # find alternative
    fzf # fuzzy finder
    font-awesome # for i3-status-rs
    gnupg
    krita # for digital art
    libreoffice-fresh # Office package
    maim # To create screenshots
    minecraft
    powerline-fonts # for powerline-go
    powerline-go # statusline for bash
    steam
    skype
    translate-shell # translate sentences in the terminal
    watson # cli time tracker
    xclip # to copy screenshots to clipboard
    xfce.thunar-archive-plugin # unzip archives
    youtube-dl # download youtube videos
  ];

  home.sessionVariables = {
    CLEAN_HOME = "~/clean";
    PATH = "$CLEAN_HOME/bin:$PATH";
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

    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "erin@erinvanderveen.nl";
      userName = "Erin van der Veen";
      extraConfig = { init.defaultBranch = "main"; };
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
        function _update_ps1() {
          PS1="$(${pkgs.powerline-go}/bin/powerline-go -error $?)"
        }
        if [ "$TERM" != "linux" ] && [ -f "${pkgs.powerline-go}/bin/powerline-go" ]; then
          PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        fi
        function cd {
          builtin cd "$@" && exa -l
        }
      '';
      shellAliases = {
        icat = "kitty +kitten icat";
        la = "exa -al";
        ll = "exa -l";
        ls = "exa";
        update = "sudo nix-channel --update";
        upgrade = "sudo nixos-rebuild switch && home-manager switch";
      };
    };

    feh.enable = true;

    firefox = {
      enable = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        duckduckgo-privacy-essentials
        ecosia
        facebook-container
        https-everywhere
        i-dont-care-about-cookies
        link-cleaner
        linkhints
        swedish-dictionary
      ];

      profiles = {
        myprofile = {
          isDefault = true;
          settings = { "general.smoothScroll" = false; };
        };
      };
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins // custom-vim-plugins; [
        YouCompleteMe
        vim-toml
        vim-css-color
        vim-clean
        vim-nix
      ];
      extraConfig = ''
        set clipboard=unnamedplus
        set dir=~/.swp
        set listchars=nbsp:¬,tab:❥\ ,extends:»,precedes:«,trail:•
        set nu rnu
        set path+=**
      '';
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
      menu = "\"${pkgs.rofi}/bin/rofi -modi window,drun,ssh,combi -show combi -font \\\\\"Ubuntu 12\\\\\" -icon-theme \\\\\"Paper\\\\\" -show-icons\"";
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
      keybindings =
        let modifier = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+s" =
            "exec --no-startup-id maim --select | xclip -selection clipboard -t image/png";
        };
    };
  };

  services = {
    nextcloud-client = { enable = true; };

    picom = {
      enable = true;
      inactiveDim = "0.2";
    };

    gnome-keyring.enable = true;

    # Notification daemon
    dunst = {
      enable = true;
      settings = {
        global = {
          background = "${background}";
          foreground = "${foreground}";
          font = "Ubuntu";
          geometry = "300x5-25+25";
        };
      };
    };
  };
  programs.i3status-rust = {
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
          warning = 20.0;
          alert = 10.0;
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
}
