{ pkgs, fetchgit }:

{
  vim-clean = pkgs.vimUtils.buildVimPlugin {
    name = "vim-clean";
    src = fetchgit {
      url = "https://gitlab.com/clean-and-itasks/vim-clean.git";
      rev = "23b5fc233aa6bee7376e347a9f91b4fb9b8d3443";
      sha256 = "1l3yb688njkbnpkfv6xq0c1269d1px1sxkn2f7dx52klzs5073ys";
    };
    dependencies = [];
  };

  onedark-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "onedark-vim";
    src = fetchgit {
      url = "https://github.com/navarasu/onedark.nvim";
      rev = "429a74a92bfad3783e804e31be1d424752bc5970";
      sha256 = "0x4pxqhrqwy6yxqrfja2w0izy6phy9q8kl1yzvabhfasmkvlmgyx";
    };
    dependencies = [];
  };
}
