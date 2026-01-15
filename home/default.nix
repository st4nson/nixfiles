{ config, pkgs, userConfig, hostConfig, ... }:

{
  # Main home-manager configuration
  # This is the entry point that imports the selected profile

  imports = [
    # Use the profile specified in user configuration
    ./profiles/${userConfig.profile}.nix
  ];

  # User information (parameterized)
  home.username = userConfig.username;
  home.homeDirectory = userConfig.homeDirectory;
  home.stateVersion = "25.05";

  # Configuration files that should be sourced directly
  home.file."Library/Application Support/com.mitchellh.ghostty/config".source = ../dotfiles/ghostty.config;
  home.file.".config/sketchybar".source = ../dotfiles/sketchybar;
}
