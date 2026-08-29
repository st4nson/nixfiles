# Common Program Configurations
#
# This module contains configurations for small, common programs that don't
# warrant their own dedicated module files. Programs with extensive configuration
# should be moved to separate files in home/programs/.

{ config, pkgs, ... }:

{
  programs = {
    # Home Manager - Enable home-manager to manage itself
    # This allows home-manager to be updated through the configuration
    home-manager.enable = true;

    # Bat - A cat clone with syntax highlighting and Git integration
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Macchiato";
      };
    };

    # Direnv - Environment variable management per directory
    direnv = {
      enable = true;
      enableZshIntegration = true;  # Integrate with zsh shell
    };

    # FZF - Command-line fuzzy finder
    fzf = {
      enable = true;
      enableZshIntegration = true;  # Add key bindings and completion to zsh
      tmux.enableShellIntegration = true;

      defaultOptions = [
        "--border"  # Show border around fzf window for clarity
        # Catppuccin-macchiato theme
        "--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796"
        "--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6"
        "--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796"
        "--color=selected-bg:#494D64"
        "--color=border:#6E738D,label:#CAD3F5"
      ];
    };

    atuin = {
      enable= true;
      daemon.enable = pkgs.stdenv.hostPlatform.isLinux;
      enableZshIntegration = true;
      settings = {
        tmux = {
          enabled = true;
          width = "80%";
          height = "60%";
        };
        theme = {
          name = "catppuccin-macchiato-mauve";
        };
      };
      themes = {
        "catppuccin-macchiato-mauve" = {
          theme.name = "catppuccin-macchiato-mauve";
          colors = {
            AlertInfo = "#a6da95";
            AlertWarn = "#f5a97f";
            AlertError = "#ed8796";
            Annotation = "#c6a0f6";
            Base = "#cad3f5";
            Guidance = "#939ab7";
            Important = "#ed8796";
            Title = "#c6a0f6";
          };
        };
      };
    };
  };
}
