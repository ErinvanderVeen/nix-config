{ self, config, lib, pkgs, ... }:

let
  inherit (lib) fileContents;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in

{
  # Sets nrdxp.cachix.org binary cache which just speeds up some builds
  imports = [ ../cachix ];

  environment = {

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      alejandra
      bat
      binutils
      coreutils
      curl
      direnv
      dnsutils
      exa
      fd
      fzf
      git
      bottom
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      trash-cli
      whois
    ];

    # Starship is a fast and featureful shell prompt
    # starship.toml has sane defaults that can be changed there
    shellInit = ''
      export STARSHIP_CONFIG=${
        pkgs.writeText "starship.toml"
        (fileContents ./starship.toml)
      }
    '';

    shellAliases =
      let
        # The `security.sudo.enable` option does not exist on darwin because
        # sudo is always available.
        ifSudo = lib.mkIf (isDarwin || config.security.sudo.enable);
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # git
        g = "git";

        # grep
        grep = "rg";
        gi = "grep -i";

        # internet ip
        # TODO: explain this hard-coded IP address
        myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

        # nix
        n = "nix";
        ns = "n search --no-update-lock-file";
        nf = "n flake";
        nepl = "n repl '<nixpkgs>'";
        srch = "ns nixos";
        orch = "ns override";
        mn = ''
          manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix
        '';
        top = "btm";

        # sudo
        s = ifSudo "sudo -E ";
        si = ifSudo "sudo -i";
        se = ifSudo "sudoedit";

        # cat
        cat = "bat";

        # ls/exa
        ls = "exa";
        l = "exa -lbF --git";
        ll = "exa -lbGF --git";
        llm = "exa -lbGd --git --sort=modified";
        la = "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale";
        lx = "exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale";
        lS = "exa -1";
        lt = "exa --tree --level=2";
      };
  };

  fonts.fonts = with pkgs; [ powerline-fonts dejavu_fonts ];

  nix = {

    # Improve nix store disk usage
    gc = {
      automatic = true;
      options = "--delete-older-than 8d";
    };

    settings = {
      # Prevents impurities in builds
      sandbox = true;

      # Give root user and wheel group special Nix privileges.
      trusted-users = [ "root" "@wheel" ];
    };

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';

  };

}
