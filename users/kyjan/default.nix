{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) kyjan; };

  users.users.kyjan = {
    name = "kyjan";
    description = "Kyjan van der Veen";
    home = "/home/kyjan";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
