{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) maatje; };

  users.users.maatje = {
    name = "maatje";
    description = "Maatje";
    hashedPassword = "$6$W4.2XHKmJsz7J7z6$HUkWiaWOfyea.I1UKofesTItWwQ8RHB3TKh4tTeEm5EzXth2GZGE0D8XDYy3mBZpUo1eHQmDoYgYIwaH7VRSE.";
    home = "/home/maatje";
    isNormalUser = true;
    extraGroups = [ "wheel" "NetworkManager" "video" ];
  };
}
