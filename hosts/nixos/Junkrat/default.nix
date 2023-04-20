{ suites, ... }: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ suites.base
    ++ suites.kyjan
    ++ suites.personal;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.interfaces.wlp2s0.useDHCP = true;

  services.xserver.displayManager.autoLogin.user = "kyjan";

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "22.11";
}
