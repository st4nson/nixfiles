{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraLuaConfig = (builtins.readFile ../../dotfiles/neovim/init.lua);
  };

  home.file.".config/nvim/lua/config".source = ../../dotfiles/neovim/lua/config;
  home.file.".config/nvim/lua/plugins".source = ../../dotfiles/neovim/lua/plugins;
}
