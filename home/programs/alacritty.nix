{ pkgs, lib, ...}:

{
  # Alacritty terminal emulator configuration
  # Note: Using file sourcing for now, can be migrated to home-manager options later

  home.packages = [
    pkgs.alacritty
  ];

  home.file.".alacritty.yml".source = ../../dotfiles/alacritty/alacritty.yml;
}
