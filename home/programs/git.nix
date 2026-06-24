{ pkgs, ... }:

# Git: structural config only. Per-host identity (userName, userEmail)
# is set by hosts/<name>.nix so the shared module stays portable.

{
  home.packages = with pkgs; [
    git-crypt
    git-lfs
    git-review
    gh
    github-copilot-cli
  ];

  programs.git = {
    enable = true;
    lfs.enable = false;
    settings = {
      # Force SSH for github.com clones regardless of how the URL was
      # specified (https:// or bare github.com/...).
      url."ssh://git@github.com".insteadOf = "https://github.com";
      url."git@github.com:".insteadOf      = "github.com/";
    };
  };
}
