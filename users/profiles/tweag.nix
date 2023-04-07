{ pkgs, ... }: {
  home = {
    packages = with pkgs;
      [
        # For google meet (FF works, but camera quality is greatly reduced)
        chromium
      ]
      ++ lib.ifSupportedPkg slack
      ++ lib.ifSupportedPkg zoom-us;
  };
}
