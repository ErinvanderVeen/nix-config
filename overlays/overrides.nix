channels: final: prev: {
  __dontExport = true; # overrides clutter up actual creations

  inherit
    (channels.latest)
    element-desktop
    discord
    helix
    lutris
    mozillavpn
    nil
    nix-index
    nixpkgs-fmt
    olive-editor# I pushed a fix for unstable, remove for 23.05
    signal-desktop
    starship
    steam
    ;

  lib =
    prev.lib
    // rec {
      # To only include a package if it is supported
      ifSupportedPkg = pkg: ifSupported pkg pkg;
      # To include anything provided the given package is supported
      ifSupported = pkg: a: prev.lib.optional (!pkg.meta.unsupported) a;
    };

  haskellPackages =
    prev.haskellPackages.override
      (old: {
        overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
          let
            version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
          in
          {
            # same for haskell packages, matching ghc versions
            inherit
              (channels.latest.haskell.packages."ghc${version}")
              haskell-language-server
              ;
          });
      });
}
