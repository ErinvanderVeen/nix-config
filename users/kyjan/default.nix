{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) kyjan; };

  users.users.kyjan = {
    name = "kyjan";
    description = "Kyjan van der Veen";
    initialHashedPassword = "$y$j9T$xWvSZ/jQPJZSsPI06hX9p.$iZnXVeMTsf/A5frbrqjjwPrXSrsfjT9ILLYK6S8wqtC";
    home = "/home/kyjan";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
