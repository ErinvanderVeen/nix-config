{ pkgs, extraModulesPath, inputs, lib, ... }:
let

  inherit (pkgs)
    cachix
    editorconfig-checker
    mdbook
    nixUnstable
    nixpkgs-fmt
    nvfetcher
    ;

  hooks = import ./hooks;

  pkgWithCategory = category: package: { inherit package category; };
  devos = pkgWithCategory "devos";
  linter = pkgWithCategory "linter";
  docs = pkgWithCategory "docs";

in
{
  _file = toString ./.;

  imports = [ "${extraModulesPath}/git/hooks.nix" ];
  git = { inherit hooks; };

  commands = [
    (devos nixUnstable)

    {
      category = "devos";
      name = nvfetcher.pname;
      help = nvfetcher.meta.description;
      command = "cd $PRJ_ROOT/pkgs; ${nvfetcher}/bin/nvfetcher -c ./sources.toml $@";
    }

    (linter nixpkgs-fmt)
    (linter editorconfig-checker)

    (docs mdbook)
  ]
  ++ lib.optionals (!pkgs.stdenv.buildPlatform.isi686) [
    (devos cachix)
  ]
  ++ lib.optionals (pkgs.stdenv.hostPlatform.isLinux && !pkgs.stdenv.buildPlatform.isDarwin) [
    (devos inputs.nixos-generators.defaultPackage.${pkgs.system})
  ]
  ;
}
