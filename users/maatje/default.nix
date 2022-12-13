{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) maatje; };

  users.users.maatje = {
    name = "maatje";
    description = "Maatje";
    hashedPassword = "$y$j9T$A4L2dC.8plzOSwqGEMBHe/$1VcvHokh.7jUR5LHVdCW3NOCKAIUgN1LfTxyBk3lxa6";
    home = "/home/maatje";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
