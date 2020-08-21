{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "st-256color";
    keyMode = "vi";
    baseIndex = 0;
    escapeTime = 0;
    historyLimit = 50000;
    clock24 = true;

    aggressiveResize = true;
    secureSocket = false;
    customPaneNavigationAndResize = true;

    extraConfig = ''
      set-option -ga terminal-overrides ",st-256color:Tc"
      set -g mouse on           # mouse support

      # stop confusion while spliting windows
      bind | split-window -h
      bind - split-window -v
      unbind %
      unbind '"'

      # Sync panes
      bind e setw synchronize-panes on
      bind E setw synchronize-panes off
    '';

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.prefix-highlight

      # TODO
      #tmuxPlugins.resurrect
      #tmuxPlugins.continuum
      #tmuxPlugins.kube-tmux
      #tmuxPlugins.nord

    ];

    tmuxinator.enable = true;
  };
}
