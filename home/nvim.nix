{ pkgs, ... }:
let
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
      rev = "85050e34134ffed6f916f6b67aab099874382d82";
      sha256 = "eHVmrJugZzsBI1nnvzre+HDsjbndSvugQ4Vj6c6gujA=";
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
  fzf-floaterm-custom = pkgs.vimUtils.buildVimPlugin {
    name = "fzf-floaterm";
    src = pkgs.fetchFromGitHub {
      owner = "voldikss";
      repo = "fzf-floaterm";
      rev = "66a30db85a7adf573af9b8a4f3f8c4ce0a2d665e";
      sha256 = "0p9grgi8hybgg7341ffn4y812axx552ncrhlak5cka3k0zpil06g";
    };
  };
  cmp-jenkinsfile-custom = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-jenkinsfile";
    src = pkgs.fetchFromGitHub {
      owner = "joshzcold";
      repo = "cmp-jenkinsfile";
      rev = "f06750822f9b2eb282ba8321d47d0a833968f6dd";
      sha256 = "gx75kAnkl8WVthKfWueCIjkwOTPqAZLXCK4J5En861I=";
    };
  };
  cmp-nvim-ultisnips-custom = pkgs.vimUtils.buildVimPlugin {
    name = "cmp-nvim-ultisnips";
    buildPhase = "echo hello";
    src = pkgs.fetchFromGitHub {
      owner = "quangnguyen30192";
      repo = "cmp-nvim-ultisnips";
      rev = "79fd645096c406fb41b38ef4dd99525965b446b1";
      sha256 = "7Hu7H5Q7XgqgMFkFLRkwqDen6535h83KnsCHsfd1yas=";
    };
  };
in
{
  programs.neovim = {
    enable = true;

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
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-jenkinsfile-custom
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lua
      cmp-nvim-ultisnips
      cmp-path
      cmp-treesitter

      nvim-lspconfig
      lsp-colors-nvim
      lspkind-nvim
      lsp_signature-nvim
      nvim-lspfuzzy-custom

      # git
      vim-fugitive
      vim-gitgutter

      # themes
      nvcode-color-schemes-vim
      lualine-nvim
      bufferline-nvim
      nvim-web-devicons

      # motion
      fzf-vim
      fzf-floaterm-custom
      nerdcommenter
      nvim-tree-lua
      vim-bufkill
      vim-easymotion
      vim-floaterm
      vim-numbertoggle
      vim-surround

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
      markdown-preview-nvim
      nvim-colorizer-lua
      vim-better-whitespace
      vim-dispatch
      vim-dispatch-neovim
      vim-slime
      vimwiki
    ];

    extraPackages = [ pkgs.git ];
    extraConfig = (builtins.readFile ../files/vimrc);
  };
}
