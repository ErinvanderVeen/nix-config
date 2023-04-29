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

  kodiPackages =
    prev.kodiPackages
    // rec
    {
      infotagger = prev.callPackage
        ({ lib
         , buildKodiAddon
         , fetchFromGitHub
         , addonUpdateScript
         ,
         }:
          buildKodiAddon rec {
            pname = "infotagger";
            namespace = "script.module.infotagger";
            version = "0.0.7";

            src = fetchFromGitHub {
              owner = "jurialmunkey";
              repo = namespace;
              rev = "v${version}";
              hash = "sha256-Us7ud0QORGn+ALB4uyISekp0kUYY8nN8uFNg8MlxEB0=";
            };

            passthru = {
              # Unusual Python path.
              pythonPath = "resources/modules";
            };
          })
        { };

      youtube = prev.callPackage
        ({ lib
         , buildKodiAddon
         , fetchzip
         , addonUpdateScript
         , six
         , requests
         , inputstreamhelper
         ,
         }:
          buildKodiAddon rec {
            pname = "youtube";
            namespace = "plugin.video.youtube";
            version = "7.0.1";

            src = fetchzip {
              url = "https://mirrors.kodi.tv/addons/nexus/${namespace}/${namespace}-${version}.zip";
              sha256 = "sha256-Wdju7d2kFX0V1J1TB75qEVq0UWN2xYYFNlD8UTt1New=";
            };

            propagatedBuildInputs = [
              six
              requests
              infotagger
              inputstreamhelper
            ];

            passthru = {
              pythonPath = "resources/lib";
            };
          })
        { };
    };

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
