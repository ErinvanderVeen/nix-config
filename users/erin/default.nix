{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) erin; };

  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    hashedPassword = "$y$j9T$A4L2dC.8plzOSwqGEMBHe/$1VcvHokh.7jUR5LHVdCW3NOCKAIUgN1LfTxyBk3lxa6";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8EiA/6R8FrrXYbhV0eIWqSv5svnXbuDr4l/qgDUQcO erin@erinvanderveen.nl"
    ];
  };
}
