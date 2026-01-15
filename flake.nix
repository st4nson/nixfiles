{
  description = "st4nson's nix configuration";

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
      # Read local config (must exist - copy from .local.nix.example)
      localConfig = import ./.local.nix;

      # Read machine profile and merge with local config
      machineConfig = import ./machines/${localConfig.machine}.nix;

      # Final merged config: machine defaults, overridden by local values
      config = machineConfig // localConfig;

      # Build hostConfig and userConfig from merged config
      hostConfig = {
        hostname = config.hostname;
        computerName = config.computerName or config.hostname;
        system = config.system;
        platform = config.platform;
      };

      userConfig = {
        username = config.username;
        fullName = config.fullName;
        email = config.email;
        homeDirectory = config.homeDirectory;
        shell = config.shell;
        profile = config.profile;
        aliases = {
          git = config.gitUser or config.username;
          github = config.githubUser or config.username;
        };
      };

      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = import ./overlays/default.nix;
      };

      mkDarwinConfiguration =
        darwin.lib.darwinSystem {
          system = hostConfig.system;
          specialArgs = {
            inherit userConfig hostConfig;
          };
          modules = [
            # Darwin configuration modules
            ./darwin

            # Home Manager integration
            home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConfig;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userConfig.username} = import ./home;
              home-manager.extraSpecialArgs = {
                inherit userConfig hostConfig;
              };
              users.users.${userConfig.username}.home = userConfig.homeDirectory;
            }
          ];
        };
    in
    {
      darwinConfigurations.default = mkDarwinConfiguration;
    };
}
