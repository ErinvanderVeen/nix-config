{ pkgs ? import <nixpkgs> {} }:

{
  cg = pkgs.stdenv.mkDerivation {
    name = "abc-code-generator";
    src = pkgs.fetchgit {
      url = "https://gitlab.science.ru.nl/clean-compiler-and-rts/code-generator.git";
      rev = "0159315ea8f7915900c4a67aea2bc659c1367799";
      sha256 = "0dbjiwasp9vqf3mpz1yvqmbzlggld24qjrk8fia4i2f5wg8ngj48";
    };
    buildInputs = with pkgs; [ gnumake gcc ];
    buildPhase = ''
      make -f Makefile.linux64 cg CFLAGS+="-Wno-format-security -DI486 -DGNU_C -DLINUX -DLINUX_ELF -DG_AI64 -O -fomit-frame-pointer"
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp cg $out/bin
    '';
  };
}
