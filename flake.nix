{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = "SSzydo";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home.nix
        {
          home = {
            username = "${username}";
            homeDirectory = "/Users/${username}";
            stateVersion = "22.11";
          };
        }
        ];
      };
    };
}
