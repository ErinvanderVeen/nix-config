{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      # Printer Nijmegen
      hplip
    ];
  };
}
