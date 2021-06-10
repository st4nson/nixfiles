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
  colorbuddy-nvim-custom = pkgs.vimUtils.buildVimPlugin {
    name = "colorbuddy.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "tjdevries";
      repo = "colorbuddy.nvim";
      rev = "87c80e3f4a590d0387d9b128d1f1fc456759408a";
      sha256 = "19gfmyhmwpr8gi03w44zm056zrzaj74hplpl4psy9mylvb0ghf0k";
    };
    buildPhase = "ls";
    #dontBuild = true;
  };
  nordbuddy-custom = pkgs.vimUtils.buildVimPlugin {
    name = "nordbuddy";
    src = pkgs.fetchFromGitHub {
      owner = "maaslalani";
      repo = "nordbuddy";
      rev = "bd59bd6378a02cc37362110266cc8a9c814fb84b";
      sha256 = "1h9pqljr5ml2yrky9jx2kjp46wcj1nbfdf67q2jvjmpx6jqavy9w";
    };
    buildPhase = "ls";
    #dontBuild = true;
    #buildInputs = [
      #(pkgs.neovim.override {
        #configure = {
          #packages.myPlugins = with pkgs.vimPlugins; {
            #start = [ plenary-nvim ];
            #opt = [];
          #};
        #};
      #})
      ##pkgs.neovim pkgs.vimPlugins.plenary-nvim
    #];
  };
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # git
      vim-fugitive
      vim-gitgutter

      #nvim-peekup
      popup-nvim
      plenary-nvim
      telescope-nvim
      nvim-lspconfig
      nvim-compe
      lsp-colors-nvim
      barbar-nvim
      nvim-web-devicons
      nvim-treesitter
      trouble-nvim
      colorbuddy-nvim-custom
      nordbuddy-custom

      #registers-nvim

      # themes
      nord-vim
      vim-airline
      vim-airline-themes
      vim-devicons

      # motion
      fzf-vim
      nerdcommenter
      nerdtree-custom
      nerdtree-git-plugin-custom
      vim-bufkill
      vim-easymotion
      vim-floaterm
      vim-surround
      vim-numbertoggle

      # programming
      Jenkinsfile-vim-syntax
      ansible-vim
      tagbar
      vim-delve-custom
      vim-go
      vim-nix
      vim-snippets
      vim-terraform

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

  home.file.".config/nvim/coc-settings.json".source = ../files/coc-settings.json;
}
