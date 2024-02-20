{ pkgs, ... }:
let
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # neovim
      nvim-treesitter.withAllGrammars
      plenary-nvim
      popup-nvim

      telescope-nvim
      trouble-nvim
      noice-nvim
      nui-nvim
      nvim-notify

      # completion & lsp
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-emoji
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp-nvim-lua
      cmp-nvim-ultisnips
      cmp-path
      cmp-treesitter

      nvim-lspconfig
      lsp-colors-nvim
      lspkind-nvim
      lsp_signature-nvim
      goto-preview

      # git
      vim-fugitive
      gitsigns-nvim

      # themes
      nvcode-color-schemes-vim
      lualine-nvim
      bufferline-nvim
      nvim-web-devicons
      catppuccin-nvim

      # motion
      nerdcommenter
      nvim-tree-lua
      vim-bufkill
      vim-easymotion
      vim-floaterm
      vim-numbertoggle
      vim-surround

      # programming
      Jenkinsfile-vim-syntax
      go-nvim
      vim-nix
      vim-terraform
      vim-test
      ultisnips
      vim-snippets

      # misc.
      direnv-vim
      goyo
      markdown-preview-nvim
      nvim-colorizer-lua
      presenting-vim
      vim-better-whitespace
      vim-dispatch
      vim-dispatch-neovim
      vim-slime
      vimwiki
    ];

    extraPackages = [ pkgs.git ];
    extraLuaConfig = (builtins.readFile ../files/init.lua);
  };
}
