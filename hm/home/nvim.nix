{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraLuaConfig = (builtins.readFile ../files/init.lua);
  };

  home.file.".config/nvim/lua/config".source = ../files/lua/config;
  home.file.".config/nvim/lua/plugins".source = ../files/lua/plugins;
}
