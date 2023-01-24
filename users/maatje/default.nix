{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) maatje; };

  users.users.maatje = {
    name = "maatje";
    description = "Maatje";
    initialHashedPassword = "$y$j9T$lP32a.ef4Wd/g7ByUVi320$gJAkVzP1daGgd/9EujzLnm.MvKwHpHKwGWkt.6KnqX1";
    home = "/home/maatje";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };
}
