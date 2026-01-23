{ pkgs, ... }:

# Linux CLI extras.
#
# Imported only by Linux hosts. Hardware introspection, password
# utilities, X11 clipboard glue. No GUI apps, no window manager —
# add features/linux-gui.nix or similar later if needed.

{
  home.packages = with pkgs; [
    lshw
    mkpasswd
    xsel
  ];
}
