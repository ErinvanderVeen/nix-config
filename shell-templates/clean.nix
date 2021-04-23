{ pkgs ? import <nixpkgs> {} }:
(
  pkgs.buildFHSUserEnv {
    name = "clean-env";
    multiPkgs = pkgs: with pkgs; [
      pkg-config
    ];
    targetPkgs = pkgs: with pkgs; [
      binutils-unwrapped
      coreutils
      gcc
      glibc
    ];
  }
).env
