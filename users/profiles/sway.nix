{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      #assigns = null;
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
        }
      ];
      #bindKeysToCode = null;
      #colors = null;
      #defaultWorkspace = null;
      #down = null;
      #floating = null;
      #focus = null;
      #fonts = null;
      #gaps = null;
      input = {
        "*" = {
          xkb_variant = "altgr-intl";
          xkb_options = "caps:swapescape";
          accel_profile = "flat";
          pointer_accel = "-0.2";
        };
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+Shift+n" = "exec swaync-client -t -swb -sw";
        };
      #keycodebindings = null;
      #left = null;
      #menu = "${pkgs.sirula}/bin/sirula";
      #modes = null;
      modifier = "Mod4";
      #output = null;
      #right = null;
      #seat = null;
      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; }
        #{ command = "${pkgs.swaywsr}/bin/swaywsr"; always = true; }
        { command = "${pkgs.workstyle}/bin/workstyle"; always = true; }
        { command = "${pkgs.swaynotificationcenter}/bin/swaync"; }
      ];
      terminal = "${pkgs.foot}/bin/foot";
      #up = null;
      #window = null;
      workspaceAutoBackAndForth = true;
      #workspaceLayout = null;
      #workspaceOutputAssign = null;
    };
    #extraConfig = null;
    #extraOptions = null;
    #extraSessionCommands = null;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
  };

  programs.waybar = {
    enable = true;
    settings = { };
  };
}
