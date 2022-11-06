{ suites, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ suites.base
  ++ suites.desktop
  ++ suites.games
  ++ suites.development;

  boot.loader = {
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  system.stateVersion = "22.05";
}