{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;

    terminal = "xterm-256color";
    keyMode = "vi";
    baseIndex = 0;
    escapeTime = 0;
    historyLimit = 50000;
    clock24 = true;

    aggressiveResize = true;
    secureSocket = false;
    customPaneNavigationAndResize = true;

    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set -g mouse on           # mouse support

      # stop confusion while spliting windows
      bind | split-window -h
      bind - split-window -v
      unbind %
      unbind '"'

      # hot-reload config file
      bind r source-file ~/.tmux.conf

      # Sync panes
      bind e setw synchronize-panes on
      bind E setw synchronize-panes off

      # Colors
      set -g pane-active-border-style bg=default,fg=#5cafb0
      set -g pane-border-style fg=#5cafb0

      # Set inactive/active window style
      set -g window-style 'bg=#373e4d'
      set -g window-active-style 'fg=#d8dee9,bg=#2e3440'
    '';

    plugins = with pkgs; [
      tmuxPlugins.copycat
      tmuxPlugins.nord
      tmuxPlugins.prefix-highlight
      tmuxPlugins.resurrect
      tmuxPlugins.yank
    ];

    tmuxinator.enable = true;
  };
}
