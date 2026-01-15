{ config, pkgs, ... }:

{
  # Main darwin configuration module
  # This imports all darwin-specific configuration modules
  
  imports = [
    ./system.nix
    ./services.nix
    ./fonts.nix
  ];
}
