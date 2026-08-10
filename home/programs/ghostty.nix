{ config, pkgs, lib, ... }:

# Ghostty terminal.
#
# Config is live-symlinked from dotfiles/ghostty/config via
# mkOutOfStoreSymlink — edits take effect immediately, no rebuild
# required.
#
# Binary install:
#   - macOS: external (DMG / cask). Adding it to nixpkgs on Darwin
#     pulls a sizeable closure and conflicts with the GUI app.
#   - Linux: from nixpkgs.

let
  inherit (pkgs.stdenv) isDarwin;

  configSource =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixfiles/dotfiles/ghostty/config";

  configPath =
    if isDarwin
    then "Library/Application Support/com.mitchellh.ghostty/config"
    else ".config/ghostty/config";

  # ncurses >= 6.6 ships the `g/ghostty` terminfo entry, which collides with
  # ghostty's own terminfo symlink in buildEnv. Drop ghostty's copy; ncurses
  # already provides the same definition.
  ghostty =
    pkgs.ghostty.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        rm $out/share/terminfo
      '';
    });
in
{
  home.packages = lib.optionals (!isDarwin) [ ghostty ];

  home.file.${configPath}.source = configSource;
}
