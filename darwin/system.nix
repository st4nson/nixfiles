{ config, pkgs, userConfig, ... }:

{
  # macOS system defaults and preferences

  # Primary user for system activation (parameterized)
  system.primaryUser = userConfig.username;

  # Global domain settings
  system.defaults.NSGlobalDomain._HIHideMenuBar = true;

  # Dock settings
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "bottom";
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 64;

  # Spaces/Mission Control settings
  system.defaults.spaces.spans-displays = false;

  # Environment variables
  environment.variables = {
    EDITOR = "vim";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Nix configuration
  nix.enable = true;
  nix.settings.trusted-users = [ "root" userConfig.username ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable zsh
  programs.zsh.enable = true;

  # State version
  system.stateVersion = 5;
}
