{ pkgs, ... }:

# Personal Linux host (build-only today — no physical machine yet).
#
# Targeted by standalone Home Manager:
#   home-manager switch --flake '.#st4nson@linux'
#
# Self-contained host description. Hosts/<name>.nix is the single
# source of truth for per-host identity + feature opt-ins.

let
  userConfig = {
    username      = "st4nson";
    fullName      = "st4nson";
    email         = "st4nson@gmail.com";
    homeDirectory = "/home/st4nson";
  };
in
{
  imports = [
    ../home
    ../home/features/linux-extras.nix
  ];

  # Make userConfig available to all imported HM modules
  # (mirrors the extraSpecialArgs pattern used on darwin hosts).
  _module.args = { inherit userConfig; };

  programs.git.userName  = userConfig.fullName;
  programs.git.userEmail = userConfig.email;
}
