{ pkgs, fetchgit }:

{
  vim-clean = pkgs.vimUtils.buildVimPlugin {
    name = "vim-clean";
    src = fetchgit {
      url = "https://gitlab.science.ru.nl/cstaps/vim-clean.git";
      rev = "d371c06a0e4450fcbe03ca6192e800c2172123a1";
      sha256 = "1l27104i1asz44sbsk1b6d5yiirff1ykizg1ba4yndc9d603z8f0";
    };
    dependencies = [];
  };
}
