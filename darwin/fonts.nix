{ config, pkgs, ... }:

{
  # Font configuration
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];
}
