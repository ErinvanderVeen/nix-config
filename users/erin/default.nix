{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) erin; };

  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8EiA/6R8FrrXYbhV0eIWqSv5svnXbuDr4l/qgDUQcO erin@erinvanderveen.nl"
    ];
  };
}
