with import <nixpkgs> {};

let
  extensions = with pkgs.vscode-extensions; [
    ms-vsliveshare.vsliveshare
  ];

  vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };
in
stdenv.mkDerivation {
  name = "cllm-env";
  nativeBuildInputs = [
    vscode-with-extensions
  ];

}
