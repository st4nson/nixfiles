{ config, pkgs, ... }:

{
  # Development profile - full development environment
  # Includes programming tools, DevOps tools, and CLI utilities

  imports = [
    ../programs/alacritty.nix
    ../programs/common.nix
    ../programs/git.nix
    ../programs/go.nix
    ../programs/nvim.nix
    ../programs/tmux.nix
    ../programs/zsh.nix

    ../packages/development.nix
    ../packages/operations.nix
    ../packages/utilities.nix
  ];
}
