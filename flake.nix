{
  description = "st4nson's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-26.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Pin opencode to a specific version via upstream overlay.
    opencode = {
      url = "github:anomalyco/opencode/v1.18.15";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, darwin, opencode, ... }:
    let
      # Reusable overlay list shared by all hosts.
      overlays = (import ./overlays) ++ [ opencode.overlays.default ];
    in
    {
      # Each host is described by a self-contained file under ./hosts/.
      # The flake just wires inputs to host descriptions.

      darwinConfigurations.work = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/work.nix
          home-manager.darwinModules.home-manager
        ];
      };

      # Standalone Home Manager target (no NixOS host yet).
      # Activate with: `home-manager switch --flake '.#st4nson@linux'`
      homeConfigurations."st4nson@linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          inherit overlays;
        };
        modules = [ ./hosts/linux.nix ];
      };

      # Future NixOS host slot (option A — when a Linux laptop materialises):
      #
      # nixosConfigurations.linux-laptop = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [ ./hosts/linux-laptop.nix ];
      # };
    };
}
