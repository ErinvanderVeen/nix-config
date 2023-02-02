{ pkgs, ... }:
{
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
}
