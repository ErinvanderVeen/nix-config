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

  systemd.services.mozillavpn-activate = {
    description = "Starts the mozilla-vpn client by user nixos after the daemon has started.";
    requires = [ "mozillavpn.service" "network.target" ];
    after = [ "mozillavpn.service" "network.target" ];
    wantedBy = [ "default.target" ];
    script = ''
      set -eux
      ${pkgs.mozillavpn}/bin/mozillavpn activate
      on=$(${pkgs.mozillavpn}/bin/mozillavpn status | ${pkgs.ripgrep}/bin/rg "VPN state: (.*)" -r '$1')
      [ "$on" = "on" ]
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "nixos";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };

  swapDevices = [{ device = "/swapfile"; size = 4096; }];

  networking = {
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
  };

  system.stateVersion = "22.11";
}
