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
  # ghostty's own terminfo symlink in buildEnv. Drop only that entry; ncurses
  # provides an equivalent definition. `x/xterm-ghostty` must stay — ghostty
  # uses it as a sentinel to locate its resources dir (and hence bundled
  # themes), so nuking the whole terminfo dir breaks theme resolution.
  ghostty =
    pkgs.ghostty.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        rm $out/share/terminfo/g/ghostty
      '';
    });
in
{
  home.packages = lib.optionals (!isDarwin) [ ghostty ];

  home.file.${configPath}.source = configSource;
}
