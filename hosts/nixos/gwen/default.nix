{ suites, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ suites.base
  ++ suites.desktop
  ++ suites.games
  ++ suites.development;

  bud.enable = true;
  bud.localFlakeClone = "/home/erin/Projects/nix-config";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    luksroot = {
      device = "/dev/disk/by-uuid/0f384a9e-bf06-406a-9a54-9ee549528af4";
      preLVM = true;
      allowDiscards = true;
    };
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  system.stateVersion = "21.11";
}
