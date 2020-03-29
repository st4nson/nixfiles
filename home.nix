{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ansible-lint
    ansible_2_7
    cfssl
    gopass
    openconnect
    redshift
    taskwarrior

    docker-compose
    docker-ls
    docker-machine

    chromium
    firefox
    icedtea8_web
    keepassxc
    libreoffice
    pidgin-with-plugins
    remmina
    shutter
    slack

    ctags
    go_1_13
    nodejs
    shellcheck
    yarn

    kubectx
    qemu
    virtmanager

    ranger
    restic
    terraform-lsp

    # Python
    pipenv
    (python3.withPackages(ps: with ps; [
      isort
      jedi
      jinja2
      pylint
      pep8
      flake8
      pyopenssl
      pytest
      pycodestyle
      pyyaml
      requests
      tox
      xmltodict
    ]))
    # TODO
    #python3Packages.black
    #python3Packages.nose
    #python3Packages.pyflakes
    #python3Packages.pygments
    #python3Packages.pyls-black
    #python3Packages.pyls-isort
    #python3Packages.pytest
    #python3Packages.python-language-server

  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "muse";
      plugins = [
        "git"
        "kube-ps1"
        "terraform"
        "vi-mode"
        "wd"
      ];
    };

    shellAliases = {
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      ip = "ip --color=auto";
      tmux="tmux -2";
    };

    sessionVariables = {
      COMPLETION_WAITING_DOTS = "true";
      FZF_TMUX = 1;
      GOPATH = "$HOME/golang";
      KEYTIMEOUT = 1;
      MODE_INDICATOR = " %{$fg_bold[blue]%}%{$reset_color%}";
      PATH = "$PATH:/usr/local/go/bin:$GOPATH/bin";
    };

    initExtra = ''
      ## Custom zsh functions
      source ~/.zsh_functions

      ## Autocompletion for k8s stuff
      source <(kubectl completion zsh)
      source <(helm completion zsh)

      # Nord 'dircolors'
      eval $(dircolors ~/.dir_colors)

      RPS1='$(kube_ps1)$(vi_mode_prompt_info)'
      '';
    };

  home.file.".zsh_functions".source = ./files/zsh_functions;
  home.file.".dir_colors".source = ./files/dir_colors;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--border"
    ];
  };

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      vim-gitgutter

      vim-airline
      vim-airline-themes
      nord-vim

      nerdtree
      nerdcommenter
      #vim-numbertoggle
      #vim-buffkill
      vim-easymotion
      vim-surround
      fzf-vim

      coc-nvim

      vimwiki
      vim-nix
      vim-terraform
    ];

    extraConfig = ''
    set nocompatible              " be iMproved, required
    filetype off                  " required

    "" Theme setup
    "set term=xterm
    set t_Co=256
    set background=dark

    let g:nord_italic = 1
    let g:nord_bold = 1
    let g:nord_italic_comments = 1
    colorscheme nord

    "" Airline plugin
    set laststatus=2  " Always show powerline
    let g:airline_theme='nord'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#coc#enabled = 1

    "" Show buffers as tabs
    let g:airline#extensions#tabline#enabled = 1

    set tabstop=4
    set shiftwidth=4
    set backspace=indent,eol,start

    "" Custom list chars
    set encoding=utf-8
    set listchars=eol:↵,trail:•,tab:\|\ 
    set list

    "" Searching
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase

    "" Show line numbers and ruler
    set number
    set colorcolumn=81

    " Disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=

    set autowrite      " autosave files on :make
    set updatetime=250 " update each 250ms
    set synmaxcol=250  " syntax hi. only for first 250 chars. Speed improvement for
                       " files with long lines
    syntax on

    "" sudo write
    cmap w!! w !sudo tee % >/dev/null

    " Fix diffs
    " highlight DiffAdd term=bold ctermfg=2 ctermbg=0
    " highlight DiffDelete term=bold ctermbg=0
    " highlight DiffChange term=bold ctermbg=0

    "" Set persistent undo
    set undofile
    set undodir=~/.vim/undodir

    " Disable swap and backup files
    set noswapfile
    set nobackup
    set nowb

    "" CoC
    set hidden
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <C-Space> (<Nul> in Vim) to trigger completion.
    inoremap <silent><expr> <C-Space> coc#refresh()
    " inoremap <silent><expr> <Nul> coc#refresh()

    " Close preview window when completion is done
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    "" fzf
    nmap <silent> <C-p> :FZF<CR>
    nmap <silent> <leader>' :Buffers<CR>
    nmap <silent> <leader>q :Tags<CR>
    nmap <silent> <leader>= :History<CR>
    imap <c-x><c-l> <plug>(fzf-complete-line)

    "" Vimwiki
    let g:vimwiki_list = [{'path': '~/.vimwiki/',
                         \ 'syntax': 'markdown',
                         \ 'ext': '.md'}]

    hi VimwikiHeader1 guifg=#afafff ctermfg=147
    hi VimwikiHeader2 guifg=#00FF00 ctermfg=10
    hi VimwikiHeader3 guifg=#0000FF ctermfg=12
    hi VimwikiHeader4 guifg=#FF00FF ctermfg=13
    hi VimwikiHeader5 guifg=#00FFFF ctermfg=14
    hi VimwikiHeader6 guifg=#FFFF00 ctermfg=11
    '';

  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";
}
