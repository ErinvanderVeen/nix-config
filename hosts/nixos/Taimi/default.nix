{ suites, ... }: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ suites.base
    ++ suites.maatje
    ++ suites.games
    ++ suites.personal;

  boot.loader = {
    systemd-boot = {
      enable = true;
      memtest86.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.interfaces.eno1.useDHCP = true;

  services.xserver.displayManager.autoLogin.user = "maatje";

  system.stateVersion = "22.05";
}
