{
  description = "st4nson's nix configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
      "https://claude-code.cachix.org"
      "https://cache.numtide.com"
    ];
    extra-trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
      "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

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

    # Offline speech-to-text (Linux only).
    handy.url = "github:cjpais/Handy/v0.9.5";
    handy.inputs.nixpkgs.follows = "nixpkgs";

    claude-code.url = "github:sadjow/claude-code-nix/?ref=v2.1.234";

    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs = { nixpkgs, nixos-hardware, home-manager, darwin, opencode, handy, claude-code, llm-agents, ... }:
    let
      # Reusable overlay list shared by all hosts.
      overlays = (import ./overlays) ++ [ opencode.overlays.default ];
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

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
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [ "libsoup-2.74.3" ];
          };
          inherit overlays;
        };
        modules = [ ./hosts/linux.nix ];
        extraSpecialArgs = { inherit handy; inherit llm-agents; };
      };

      nixosConfigurations.shodan = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/shodan.nix
          ./nix/substituter.nix
          nixos-hardware.nixosModules.apple-t2
        ];
      };
    };
}
