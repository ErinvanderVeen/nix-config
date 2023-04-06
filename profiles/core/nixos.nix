{ config, lib, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  time.timeZone = lib.mkDefault "Europe/Stockholm";

  networking.networkmanager.enable = true;

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
        # systemd
        ctl = "systemctl";
        stl = ifSudo "s systemctl";
        utl = "systemctl --user";
        jtl = "journalctl";
      };
  };

  fonts.fontconfig.defaultFonts = {
    monospace = [ "DejaVu Sans Mono" ];
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

  programs.ssh = {
    startAgent = true;
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

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # X11 related configuration
  services.xserver = {
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "altgr-intl";

    libinput = {
      # Enable touchpad support (enabled default in most desktopManager).
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "-0.5";
      };
    };
  };

  users.mutableUsers = true;

  # Sound
  sound.enable = true;
  # rtkit allows pipewire to get real time scheduling on demand (recommended by nixos wiki)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  hardware = {
    pulseaudio.enable = false;
    enableRedistributableFirmware = true;
  };
}
