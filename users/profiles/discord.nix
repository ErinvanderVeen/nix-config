{ pkgs, ... }: {
  home = {
    packages = pkgs.lib.ifSupportedPkg pkgs.discord;
  };
}
