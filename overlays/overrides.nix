channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    discord
    element-desktop
    helix
    lutris
    mozillavpn
    nil
    nix-index
    nixpkgs-fmt
    olive-editor# I pushed a fix for unstable, remove for 23.05
    signal-desktop
    starship
    ;

  vimPlugins = prev.vimPlugins // {
    inherit (channels.latest.vimPlugins)
      noice-nvim
      ;
  };

  haskellPackages = prev.haskellPackages.override
    (old: {
      overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (hfinal: hprev:
        let version = prev.lib.replaceChars [ "." ] [ "" ] prev.ghc.version;
        in
        {
          # same for haskell packages, matching ghc versions
          inherit (channels.latest.haskell.packages."ghc${version}")
            haskell-language-server;
        });
    });
}
