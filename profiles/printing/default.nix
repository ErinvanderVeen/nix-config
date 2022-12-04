{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      # Printer Nijmegen
      hplip
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
  };
}
