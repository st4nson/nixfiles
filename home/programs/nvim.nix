{ config, pkgs, lib, ... }:

# Neovim.
#
# The binary + LSPs/linters are installed declaratively. The Lua config
# (init.lua, lua/config/*, lua/plugins/*) is live-symlinked to
# dotfiles/neovim so edits take effect immediately without a rebuild.
# Plugins are managed by lazy.nvim; its lockfile (lazy-lock.json) lives
# inside the symlinked tree and is committed to git for cross-host
# reproducibility.

{
  programs.neovim = {
    enable    = true;
    viAlias   = true;
    vimAlias  = true;
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/git/nixfiles/dotfiles/neovim";
}
