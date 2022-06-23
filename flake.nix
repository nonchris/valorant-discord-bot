{
  description = "get valorant rank from API";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:


    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {

        # Use nixpkgs-fmt for `nix fmt'
        formatter = pkgs.nixpkgs-fmt;

        defaultPackage = packages.discord_bot;
        packages = flake-utils.lib.flattenTree rec {

          discord_bot = with pkgs.python3Packages;
            pkgs.python3Packages.buildPythonPackage rec {
              pname = "discord_bot";
              version = "0.1";
              propagatedBuildInputs = [ discordpy requests sqlalchemy ];
              doCheck = false;
              src = self;
              meta = with pkgs.lib; {
                description = "get valorant rank from API";
                homepage = "https://github.com/MayNiklas/discord-bot-valorant-rank/";
                platforms = platforms.unix;
                maintainers = with maintainers; [ mayniklas ];
              };
            };

        };


      });
}