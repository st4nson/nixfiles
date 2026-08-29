{ pkgs, handy, llm-agents, ... }:

# Linux CLI extras.
#
# Imported only by Linux hosts. Hardware introspection, password
# utilities, X11 clipboard glue. No GUI apps, no window manager —
# add features/linux-gui.nix or similar later if needed.

{
  home.packages = with pkgs; [
    citrix_workspace
    claude-code
    google-chrome
    handy.packages.x86_64-linux.handy
    keepassxc
    llm-agents.packages.x86_64-linux.pi
    localsend
    lshw
    libreoffice
    mkpasswd
    opencode
    slack
    teams-for-linux
    xsel
  ];
}
