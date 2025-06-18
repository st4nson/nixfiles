{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }:
    let
      system = "aarch64-darwin";
      username = "sszydo";
      homedir = "Users";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ../hm/home.nix
        {
          home = {
            username = "${username}";
            homeDirectory = "/${homedir}/${username}";
            stateVersion = "24.11";
          };
        }
        ];
      };
    };
}
