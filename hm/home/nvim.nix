{ pkgs, ... }: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraLuaConfig = (builtins.readFile ../files/init.lua);
  };

  home.file.".config/nvim/init.lua_test".source = ../files/init.lua;
  home.file.".config/nvim/lua/config/lazy.lua".source = ../files/lazy.lua;
  home.file.".config/nvim/lua/plugins/plugins.lua".source = ../files/plugins.lua;
}
