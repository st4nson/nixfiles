{
  description = "st4nson's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }:
    let
      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        # overlays example: https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050
      };
    in
    {
    darwinConfigurations."AP7TXJWN60C1AE" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin-configuration.nix
        home-manager.darwinModules.home-manager
        {
            nixpkgs = nixpkgsConfig;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sszydo = import ../hm/home.nix;
            users.users.sszydo.home = "/Users/sszydo";
        }
      ];
    };
  };
}
