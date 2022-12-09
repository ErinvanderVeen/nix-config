{ config, lib, pkgs, self, ... }:

{
  imports = [
    ./common.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  environment = {

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ];

    shellAliases =
      let ifSudo = lib.mkIf config.security.sudo.enable; in
      {
        # nix
        nrb = ifSudo "sudo nixos-rebuild";

        # fix nixos-option for flake compat
        nixos-option = "nixos-option -I nixpkgs=${self}/lib/compat";

        # systemd
        ctl = "systemctl";
        stl = ifSudo "s systemctl";
        utl = "systemctl --user";
        ut = "systemctl --user start";
        un = "systemctl --user stop";
        up = ifSudo "s systemctl start";
        dn = ifSudo "s systemctl stop";
        jtl = "journalctl";
      };
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVu Sans Mono for Powerline" ];
    sansSerif = [ "DejaVu Sans" ];
  };

  nixpkgs = {
    # enable unfree packages
    config.allowUnfree = true;
  };

  nix = {
    settings = {
      # Improve nix store disk usage
      auto-optimise-store = true;

      allowed-users = [ "@wheel" ];

      # This is just a representation of the nix default
      system-features = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    };
    optimise.automatic = true;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;

  # Make sure we have a decent default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh = {
    enable = true;
    openFirewall = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Service that makes Out of Memory Killer more effective
  services.earlyoom.enable = true;

  # X11 related configuration
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "altgr-intl";
    xkbOptions = "caps:swapescape";

    libinput = {
      # Enable touchpad support (enabled default in most desktopManager).
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "-0.5";
      };
    };
  };

  # Sound
  sound.enable = true;
  # rtkit allows pipewire to get real time scheduling on demand (recommended by nixos wiki)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware.pulseaudio.enable = false;

  # Boot related
  boot.plymouth.enable = true;
}
