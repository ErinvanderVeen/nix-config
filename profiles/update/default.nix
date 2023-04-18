# This module is reponsible for automatically keeping our NixOS machines up to date
{ pkgs
, lib
, config
, ...
}: {
  system.autoUpgrade = {
    enable = true;
    dates = "Sun";
    randomizedDelaySec = "10min";
    # Override for our servers
    allowReboot = lib.mkDefault false;
    flags = [ "--update-input" "nixpkgs" "--no-write-lock-file" ];
    flake = "github:ErinvanderVeen/nix-config";
  };

  environment.shellAliases =
    let
      ifSudo = lib.mkIf config.security.sudo.enable;
    in
    {
      nixos-update = ifSudo "sudo nixos-rebuild switch --flake github:ErinvanderVeen/nix-config --update-input nixpkgs --update-input nixos --update-input latest --no-write-lock-file";
    };
}
