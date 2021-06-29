{ pkgs, ... }:
let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs {};

  nerdtree-custom = pkgs.vimUtils.buildVimPlugin {
    name = "nerdtree";
    src = pkgs.fetchFromGitHub {
      owner = "preservim";
      repo = "nerdtree";
      rev = "1b19089917cc3e0a81d3294fead2424c419d545c";
      sha256 = "0zm60spnz4nsn0g9zsdiapygr2nwnkrqcz0w2pr37sp9i91nxxvb";
    };
  };
  nerdtree-git-plugin-custom = pkgs.vimUtils.buildVimPlugin {
    name = "nerdtree-git-plugin";
    src = pkgs.fetchFromGitHub {
      owner = "Xuyuanp";
      repo = "nerdtree-git-plugin";
      rev = "6b843d3742d01b98a229ed2e6d3782f6d3f21651";
      sha256 = "10mc9ir2h9swbyqfvg4gl3qkyc95s478wfl449zypsjnfisq7526";
    };
  };
  vim-dispatch-neovim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dispatch-neovim-custom";
    src = pkgs.fetchFromGitHub {
      owner = "radenling";
      repo = "vim-dispatch-neovim";
      rev = "c8c4e21a95c25032a041002f9bf6e45a75a73021";
      sha256 = "111n3f7lv9nkpj200xh0fwbi3scjqyivpw5fwdjdyiqzd6qabxml";
    };
  };
  vim-delve-custom = pkgs.vimUtils.buildVimPlugin {
    name = "vim-delve";
    src = pkgs.fetchFromGitHub {
      owner = "sebdah";
      repo = "vim-delve";
      rev = "554b7997caba5d2b38bc4a092e3a468e4abb7f18";
      sha256 = "11qsvw3qsrkwmdks6mhmygmwzi9ma8vhx77kid5s7p936i8xdmxr";
    };
  };
  nvim-lspfuzzy-custom = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-lspfuzzy";
    src = pkgs.fetchFromGitHub {
      owner = "ojroques";
      repo = "nvim-lspfuzzy";
      rev = "2f172ab6a8993913f52ba6beb3eb809112f6107f";
      sha256 = "16xmasy7zq4jrg8dj74ljlcz1azsklsma6rkywhivbc2ir6kqcxj";
    };
  };
  lsp-signature-custom = pkgs.vimUtils.buildVimPlugin {
    name = "lsp_signature.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ray-x";
      repo = "lsp_signature.nvim";
      rev = "ef20fad69270f4d3df356be3c01bd079739e72c4";
      sha256 = "0whmqkz6k27hrsjmbw841bsdg8xkiv8gj01sw40cg99mcdyags70";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # neovim
      nvim-treesitter
      plenary-nvim
      popup-nvim

      telescope-nvim
      trouble-nvim

      # completion & lsp
      nvim-compe
      nvim-lspconfig
      lsp-colors-nvim
      lspkind-nvim
      lsp-signature-custom
      nvim-lspfuzzy-custom

      # git
      vim-fugitive
      vim-gitgutter

      # themes
      nvcode-color-schemes-vim
      lualine-nvim
      nvim-bufferline-lua
      nvim-web-devicons

      # motion
      fzf-vim
      nerdcommenter
      nerdtree-custom
      nerdtree-git-plugin-custom
      nvim-tree-lua
      vim-bufkill
      vim-easymotion
      vim-floaterm
      vim-surround
      vim-numbertoggle

      # programming
      Jenkinsfile-vim-syntax
      vim-delve-custom
      vim-go
      vim-nix
      vim-terraform
      vim-test
      ultisnips
      vim-snippets

      # misc.
      direnv-vim
      goyo
      vim-better-whitespace
      vim-dispatch
      vim-dispatch-neovim-custom
      vim-slime
      vimwiki
    ];

    extraConfig = (builtins.readFile ../files/vimrc);
  };
}
