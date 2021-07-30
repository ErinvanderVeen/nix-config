{ pkgs, fetchFromGitHub, kakouneUtils }:

{
  one-kak = kakouneUtils.buildKakounePluginFrom2Nix {
    name = "one-kak";
    src = fetchFromGitHub {
      owner = "raiguard";
      repo = "one.kak";
      rev = "5444ccc2f320f4dd90c7246777b6201d62a30d05";
      sha256 = "150plih71kr7jhxkbdvq878g8yakxq3j1jyk1k3hw8c8z033wsl1";
    };
    meta.homepage = "https://github.com/raiguard/one.kak";
  };
}
