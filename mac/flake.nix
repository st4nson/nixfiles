{
  description = "st4nson's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }:
  {
    darwinConfigurations."AP70MD6RE61E65" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./darwin-configuration.nix
      ];
      inputs = { inherit darwin nixpkgs; };
    };
  };
}
