{
  config,
  pkgs,
  lib,
  ...
}:

# Work machine

{
  imports = [
    ../darwin
    ../modules/identity.nix
  ];

  userConfig = {
    username = "st4nson";
    fullName = "Stanisław Szydło";
    email = "st4nson@gmail.com";
    homeDirectory = "/Users/st4nson";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = import ../overlays;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.userConfig.username} = {
    imports = [
      ../home
      #../home/features/nike-work.nix
    ];

    userConfig = config.userConfig;
  };

  users.users.${config.userConfig.username}.home = config.userConfig.homeDirectory;
}
