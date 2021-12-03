{
  description = "st4nson's darwin system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.05-darwin";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-21.11";
    #home-manager.url = "github:nix-community/home-manager/release-21.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay/b8619f5196d6257b147722b394d3dadb3f5eaa9a";
  };

  outputs = { self, darwin, nixpkgs, home-manager, neovim-nightly-overlay }:
    let
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
        overlays = [
            #neovim-nightly-overlay.overlay
        ];
      };
    in
 {
      darwinConfigurations."st4nson-MacBook" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
           ./mac/darwin-configuration.nix
           home-manager.darwinModules.home-manager
           {
             # nixpkgs = nixpkgsConfig;
             nixpkgs = nixpkgsConfig;
             # Hack to support legacy worklows that use `<nixpkgs>` etc.
             # nix.nixPath = { nixpkgs = "$HOME/.config/nixpkgs/nixpkgs.nix"; };
             # `home-manager` config
             users.users.SSzydo.home = "/Users/SSzydo";
             home-manager.useGlobalPkgs = true;
             home-manager.users.SSzydo = with self.homeManagerModules; {
               imports = [
                 ./home.nix
               ];
             };
           }
        ];
      };
  };
}
