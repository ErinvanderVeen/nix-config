{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) maatje; };

  users.users.maatje = {
    name = "maatje";
    description = "Maatje";
    home = "/home/maatje";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
