{ config, pkgs, ... }:

# Git: structural config plus commit identity from userConfig.

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
      user = {
        name = config.userConfig.fullName;
        email = config.userConfig.email;
      };

      # Force SSH for github.com clones regardless of how the URL was
      # specified (https:// or bare github.com/...).
      # url."ssh://git@github.com".insteadOf = "https://github.com";
      # url."git@github.com:".insteadOf      = "github.com/";
    };
  };
}
