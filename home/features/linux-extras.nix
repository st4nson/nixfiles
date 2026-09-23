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
    gparted
    handy.packages.x86_64-linux.handy
    keepassxc
    libreoffice
    llm-agents.packages.x86_64-linux.pi
    localsend
    lshw
    ntfs3g
    heroic
    mkpasswd
    opencode
    slack
    teams-for-linux
    xsel
  ];
}
