{ pkgs, llm-agents, ... }:

# Linux CLI extras.
#
# Imported only by Linux hosts. Hardware introspection, password
# utilities, X11 clipboard glue. No GUI apps, no window manager —
# add features/linux-gui.nix or similar later if needed.

{
  home.packages = with pkgs; [
    citrix_workspace
    google-chrome
    gparted
    heroic
    keepassxc
    libreoffice
    llm-agents.packages.x86_64-linux.claude-code
    llm-agents.packages.x86_64-linux.handy
    llm-agents.packages.x86_64-linux.opencode
    llm-agents.packages.x86_64-linux.pi
    localsend
    lshw
    mkpasswd
    ntfs3g
    slack
    teams-for-linux
    xsel
  ];
}
