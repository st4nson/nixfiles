# Personal machine profile
# Contains non-sensitive, abstract configuration.
# Sensitive values (hostname, email, etc.) come from .local.nix

{
  # Platform
  system = "aarch64-darwin";
  platform = "darwin";

  # Shell
  shell = "zsh";

  # User profile for package selection
  profile = "development";  # Options: minimal, development, full
}
