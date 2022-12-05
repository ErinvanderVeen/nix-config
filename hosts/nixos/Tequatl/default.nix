{ suites, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ suites.base
  ++ suites.laptop
  ++ suites.games
  ++ suites.development;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  system.stateVersion = "22.11";
}
