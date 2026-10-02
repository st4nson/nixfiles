{ ... }:

# Darwin-only Home Manager config.
#
# Imported only by Darwin hosts. Currently just the sketchybar dotfile
# symlink, which has no meaning on Linux.

{
  home.file.".config/sketchybar".source = ../../dotfiles/sketchybar;
}
