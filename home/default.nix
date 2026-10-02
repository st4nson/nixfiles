{
  config,
  ...
}:

# Home Manager entry point.
#
# Platform-agnostic baseline: anything universally wanted regardless of
# whether this evaluates on a Darwin host (via nix-darwin) or a Linux
# host (via standalone Home Manager / future NixOS module).
#
# Host- or platform-specific opt-ins (Linux CLI extras, Darwin extras,
# etc.) live under ./features/ and are imported only by the relevant
# hosts/<name>.nix.

{
  imports = [
    ../modules/identity.nix

    # Programs
    ./programs/common.nix
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/go.nix
    ./programs/nvim.nix
    ./programs/tmux.nix
    ./programs/zsh.nix
    ./programs/ollama.nix

    # Package bundles
    ./packages/development.nix
    ./packages/operations.nix
    ./packages/utilities.nix
  ];

  home.username = config.userConfig.username;
  home.homeDirectory = config.userConfig.homeDirectory;
  home.stateVersion = "25.05";

  home.sessionVariables.EDITOR = "vim";
}
