# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  programs.steam.enable = true;

  # Unfree packages :( Required for nvidia drivers
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/0f384a9e-bf06-406a-9a54-9ee549528af4";
      preLVM = true;
      allowDiscards = true;
    };
  };

  networking.hostName = "Gwen"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "se_NO.UTF-8";
  console.useXkbConfig = true;
  i18n.extraLocaleSettings = {
    LANGUAGE = "se_NO.UTF-8";
    LC_ALL = "se_NO.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "altgr-intl";
  services.xserver.xkbOptions = "caps:swapescape";
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    daemon.config = {
      alternate-sample-rate = "44100";
      daemonize = "no";
      default-sample-format = "float32le";
      default-sample-rate = 48000;
      enable-lfe-remixing = "no";
      high-priority = "yes";
      nice-level = -11;
      realtime-priority = 9;
      realtime-scheduling = "yes";
      resample-method = "soxr-vhq";
      rlimit-rtprio = 9;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";
  services.xserver.libinput.mouse.accelSpeed = "-0.5";

  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  # Ensure kwallet runs on lightdm logon, needed for nextcloud
  security.pam.services.lightdm.enableKwallet = true;

  # Enable i3
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        thunarPlugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
      };
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "erin";
      };
      lightdm = {
        enable = true;
        background = "/etc/nixos/background_image.jpg";
        greeters = { enso = { enable = true; }; };
      };
      defaultSession = "xfce+i3";
    };

    windowManager.i3 = { enable = true; };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.erin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    htop
    killall
    wget
    kwallet-pam
    plasma5Packages.kwallet
    (neovim.override {
      viAlias = true;
      vimAlias = true;
    })
  ];

  # Neovim
  environment.variables = { EDITOR = "vim"; };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

