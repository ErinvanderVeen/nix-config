{ hmUsers, suites, inputs, ... }:
{
  home-manager.users = { inherit (hmUsers) erin; };

  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    initialHashedPassword = "$y$j9T$xMVMs3Pdccm9jI1CUV4Be0$ruxg5.m4KHPS3OxQ6X/s6jKgmXx5ZBMsydbGjUIX05/";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8EiA/6R8FrrXYbhV0eIWqSv5svnXbuDr4l/qgDUQcO erin@erinvanderveen.nl"
    ];
  };
}
