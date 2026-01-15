{ config, pkgs, ... }:

{
  # Full profile - everything including GUI applications
  # This is the complete setup with all tools

  imports = [
    ./development.nix
    ../packages/gui.nix
  ];
}
