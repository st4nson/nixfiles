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
      set -g window-style 'bg=#1e1e2e'
      set -g window-active-style 'fg=#cad3f5,bg=#24273a'
    '';

    plugins = with pkgs; [
      tmuxPlugins.copycat
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato' # or frappe, macchiato, mocha
        '';
      }
      tmuxPlugins.prefix-highlight
      tmuxPlugins.resurrect
      tmuxPlugins.yank
    ];

    tmuxinator.enable = true;
  };
}
