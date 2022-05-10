{ hmUsers, suites, ... }:
{
  home-manager.users = { inherit (hmUsers) erin; };

  users.users.erin = {
    name = "erin";
    description = "Erin van der Veen";
    hashedPassword = "$6$EFNn1XO7gCIxo4Yx$NJ3x1XWT9/7ONYVp1ZgzkyLToeUMdPSY38UdlA5nLQ9Yu4z4KBcLQr4/OxwWw8oKAtquXYrZf7nyUXWmHBHpi1";
    home = "/home/erin";
    isNormalUser = true;
    extraGroups = [ "wheel" "NetworkManager" "docker" ];
    openssh.authorizedKeys.keys = [
      ''
        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC3x2bjJ6q2XF5Po3sSoqC5C3AoiFR20cg+zuZh5QNuKHg1JeLm9270AsBkjJFU06AqVDQTHhrMxp/YEMOHqKgzujX6kp1+xmPaJgjuXh1a1yG8QM4EmBuYHJ4gk5MvRRMwKuqDFzOG0AmhjmBGNsfs8UkGyq92DGN7GQ+Zi3R6e6HW/Z4XeVMZG+WQscpJiiEntYrIN5oJ5H4CXem8IbLpCpplvF4zlb02D3BGa2BmlpCdvY1SxosfXBWP4jREiRBtJQtzP7T4144Gq1Psr5ge7kEH7qg1llTiuU75hEYsqPsL+5GBFIItS3czfg4ToMb/D2Vwuku0NbGh+uH9wUIthDmmOjwWHugmus0SlK39ZmOMi2QcEo0pQJhhNhUA07hcuSQ7IsqEeg+3hcUD5rzDKE5Gl7eRUi53OjBMCHFqJt3bNnYGv6F0v+V3uf2fPPWy/7AGVmUGwF937wa4Pw4w/bxjXYuN6BGmQuDENFm0aDRPJkt7F+GcPZjSxjBWKi9Qq+Cyph+c6lcbZJuw9WgKz2VW+xPMIZZ6QkWGvU+n763EVNuOszbpy0D92svyzfWBR3ZvbDAF/l/RnGAuMQs4nBbCzLYV1cDlxfyUH9TmQ6/xirG/xmK2gy0KTuZzpzk3h9N9kjBiGHcs2eHWjia0/9RwPH3gJKQUCeGQHZoMMw== erin@erinvanderveen.nl
      ''
    ];
  };
}
