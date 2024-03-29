{
  description = "A highly structured configuration database.";

  nixConfig.extra-experimental-features = "nix-command flakes";
  nixConfig.extra-substituters = "https://nrdxp.cachix.org https://nix-community.cachix.org";
  nixConfig.extra-trusted-public-keys = "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";

  inputs = {
    # Track channels with commits tested and built by hydra
    nixos.url = "github:nixos/nixpkgs/nixos-22.11";
    latest.url = "github:nixos/nixpkgs/nixos-unstable";
    # For darwin hosts: it can be helpful to track this darwin-specific stable
    # channel equivalent to the `nixos-*` channels for NixOS. For one, these
    # channels are more likely to provide cached binaries for darwin systems.
    # But, perhaps even more usefully, it provides a place for adding
    # darwin-specific overlays and packages which could otherwise cause build
    # failures on Linux systems.
    nixpkgs-darwin-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    digga.url = "github:divnix/digga";
    digga.inputs.nixpkgs.follows = "nixos";
    digga.inputs.nixlib.follows = "nixos";
    digga.inputs.home-manager.follows = "home";

    home.url = "github:nix-community/home-manager/release-22.11";
    home.inputs.nixpkgs.follows = "nixos";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin-stable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixos-generators.url = "github:nix-community/nixos-generators";
  };

  outputs =
    { self
    , digga
    , nixos
    , home
    , nixos-hardware
    , nixpkgs
    , ...
    } @ inputs:
    digga.lib.mkFlake
      {
        inherit self inputs;

        channelsConfig = { allowUnfree = true; };

        channels = {
          nixos = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ ];
          };
          nixpkgs-darwin-stable = {
            imports = [ (digga.lib.importOverlays ./overlays) ];
            overlays = [ ];
          };
          latest = { };
        };

        lib = import ./lib { lib = digga.lib // nixos.lib; };

        sharedOverlays = [
          (final: prev: {
            __dontExport = true;
            lib = prev.lib.extend (lfinal: lprev: {
              our = self.lib;
            });
          })
        ];

        nixos = {
          hostDefaults = {
            system = "x86_64-linux";
            channelName = "nixos";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.nixosModules.bootstrapIso
              digga.nixosModules.nixConfig
              home.nixosModules.home-manager
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/nixos) ];
          hosts = {
            # Default configuration (for bootstrap ISO etc)
            NixOS = { };
            Aurene = {
              channelName = "nixos";
              modules = with nixos-hardware.nixosModules; [
                common-cpu-intel
                common-cpu-intel-kaby-lake
                common-pc-laptop
                common-pc-laptop-ssd
              ];
            };
            Gwen = {
              channelName = "nixos";
              modules = with nixos-hardware.nixosModules; [
                common-gpu-amd
                common-pc
                common-pc-ssd
              ];
            };
            Taimi = {
              channelName = "nixos";
              modules = with nixos-hardware.nixosModules; [
                common-gpu-nvidia-nonprime
                common-pc
                common-pc-ssd
              ];
            };
            Tequatl = {
              channelName = "nixos";
              modules = with nixos-hardware.nixosModules; [
                lenovo-thinkpad-x1-9th-gen
              ];
            };
            Junkrat = {
              channelName = "nixos";
              modules = with nixos-hardware.nixosModules; [
                common-cpu-intel
                common-cpu-intel-kaby-lake
                common-pc-laptop
                common-pc-laptop-ssd
              ];
            };
            Tybalt = {
              channelName = "nixos";
              system = "aarch64-linux";
              modules = with nixos-hardware.nixosModules; [
                raspberry-pi-4
              ];
            };
          };
          importables = rec {
            inherit nixos-hardware;
            profiles =
              digga.lib.rakeLeaves ./profiles
              // {
                users = digga.lib.rakeLeaves ./users;
              };
            suites = with profiles; rec {
              base = [ core.nixos users.root update ];
              maatje = [ users.maatje ];
              erin = [ users.erin ];
              kyjan = [ users.kyjan ios ];
              # Personal computing
              personal = [ gnome printing desktop-config ];
              server = [ syncthing users.nixos update-reboot ];
              home-server = [ jellyfin transmission media-group autostart-vpn kodi ];
              vpn = [ mozillavpn ];
              tiling = [ sway ];
              games = [ steam minecraft ];
            };
          };
        };

        darwin = {
          hostDefaults = {
            system = "x86_64-darwin";
            channelName = "nixpkgs-darwin-stable";
            imports = [ (digga.lib.importExportableModules ./modules) ];
            modules = [
              { lib.our = self.lib; }
              digga.darwinModules.nixConfig
              home.darwinModules.home-manager
            ];
          };

          imports = [ (digga.lib.importHosts ./hosts/darwin) ];
          hosts = {
            /*
          set host-specific properties here
            */
            Mac = { };
          };
          importables = rec {
            profiles =
              digga.lib.rakeLeaves ./profiles
              // {
                users = digga.lib.rakeLeaves ./users;
              };
            suites = with profiles; rec {
              base = [ core.darwin users.darwin ];
            };
          };
        };

        home = {
          imports = [ (digga.lib.importExportableModules ./users/modules) ];
          modules = [ ];
          importables = rec {
            profiles = digga.lib.rakeLeaves ./users/profiles;
            suites = with profiles; rec {
              base = [ core direnv helix bat skim ];
              creative = [ digital-art ];
              desktop = [ desktop-packages discord ];
              development = [ git lazygit github ssh alacritty ];
              game-debug = [ mangohud ];
              games = [ minecraft lutris ];
              kyjan = [ kyjan-packages ];
              maatje = [ maatje-packages ];
              backup = [ syncthing ];
              terminal-desktop = [ terminal-packages ];
              tilling = [ sway ];
              work = [ tweag ];
            };
          };
          users = {
            # Server user
            nixos = { suites, ... }: {
              imports =
                suites.base
                ++ suites.development;
            };
            # My personal user
            erin = { suites, ... }: {
              imports =
                suites.base
                ++ suites.desktop
                ++ suites.development
                ++ suites.game-debug
                ++ suites.games
                ++ suites.terminal-desktop
                ++ suites.tilling
                ++ suites.backup
                ++ suites.work;
            };
            maatje = { suites, ... }: {
              imports =
                suites.base
                ++ suites.desktop
                ++ suites.creative
                ++ suites.backup
                ++ suites.maatje
                ++ suites.games;
            };
            kyjan = { suites, ... }: {
              imports =
                suites.base
                ++ suites.desktop
                ++ suites.kyjan;
            };

            darwin = { suites, ... }: { imports = suites.base; };
          };
        };

        devshell = ./shell;

        # TODO: similar to the above note: does it make sense to make all of
        # these users available on all systems?
        homeConfigurations =
          digga.lib.mergeAny
            (digga.lib.mkHomeConfigurations self.darwinConfigurations)
            (digga.lib.mkHomeConfigurations self.nixosConfigurations);
      };
}
