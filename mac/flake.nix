{
  description = "st4nson's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }:
  {
    darwinConfigurations."APLQH75K080966" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./darwin-configuration.nix
      ];
      inputs = { inherit darwin nixpkgs; };
    };
  };
}
