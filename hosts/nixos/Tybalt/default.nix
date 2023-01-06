{ suites, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ suites.base
  ++ suites.vpn
  ++ suites.server
  ++ suites.home-server
  ;

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
        "8250.nr_uarts=1"
        "console=ttyAMA0,115200"
        "console=tty1"
        # A lot GUI programs need this, nearly all wayland applications
        "cma=128M"
    ];
  };

  #boot.loader.raspberryPi = {
    #enable = true;
    #version = 4;
  #};
  #boot.loader.grub.enable = false;
  #boot.loader.systemd-boot.enable = false;
  #boot.loader.generic-extlinux-compatible.enable = false;

  networking = {
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
    # ERror in journalctl
    enableIPv6 = false;
  };

  system.stateVersion = "22.11";
}
