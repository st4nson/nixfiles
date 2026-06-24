{ pkgs, lib, ... }:

# Work machine

let
  userConfig = {
    username      = "sszydo";
    fullName      = "Stanisław Szydło";
    email         = "stanislaw.szydlo@nike.com";
    homeDirectory = "/Users/sszydo";
  };
in
{
  imports = [
    ../darwin
  ];

  # Make userConfig available to all darwin modules
  # (replaces the flake-level `specialArgs` plumbing).
  _module.args = { inherit userConfig; };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays           = import ../overlays;

  home-manager.useGlobalPkgs    = true;
  home-manager.useUserPackages  = true;
  home-manager.extraSpecialArgs = { inherit userConfig; };

  home-manager.users.${userConfig.username} = {
    imports = [
      ../home
      ../home/features/nike-work.nix
    ];

    programs.git.settings.user.name  = userConfig.fullName;
    programs.git.settings.user.email = userConfig.email;
  };

  users.users.${userConfig.username}.home = userConfig.homeDirectory;
}
