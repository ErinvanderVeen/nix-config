{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) erin; };

  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    hashedPassword = "$6$EFNn1XO7gCIxo4Yx$NJ3x1XWT9/7ONYVp1ZgzkyLToeUMdPSY38UdlA5nLQ9Yu4z4KBcLQr4/OxwWw8oKAtquXYrZf7nyUXWmHBHpi1";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8EiA/6R8FrrXYbhV0eIWqSv5svnXbuDr4l/qgDUQcO erin@erinvanderveen.nl"
    ];
  };
}
