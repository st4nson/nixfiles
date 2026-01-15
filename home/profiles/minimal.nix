{ config, pkgs, ... }:

{
  # Minimal profile - essential tools only
  # Suitable for servers or minimal setups

  imports = [
    ../programs/common.nix
    ../programs/git.nix
    ../programs/zsh.nix
  ];

  # Only include essential utilities
  home.packages = with pkgs; [
    fd
    htop
    jq
    ripgrep
    wget
  ];
}
