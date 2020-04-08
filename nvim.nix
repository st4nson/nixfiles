{ config, pkgs, ... }:

{
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
      vim-easymotion
      vim-surround
      fzf-vim

      coc-nvim

      ansible-vim
      vim-go
      vim-nix
      vim-terraform
      tagbar

      vimwiki
      goyo
      vim-slime
      vim-dispatch
    ];

    extraConfig = ''
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " Setup plugins not yet available in 'Nix Store'
    set runtimepath^=~/.local/share/nvim/site/vim-bufkill/start
    set runtimepath^=~/.local/share/nvim/site/vim-numbertoggle/start
    set runtimepath^=~/.local/share/nvim/site/vim-dispatch-neovim/start

    filetype plugin indent on    " required

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

    "" buffers navigation
    nmap <silent> <leader>[ :bprevious<CR>
    nmap <silent> <leader>] :bnext<CR>
    nmap <silent> <leader>; :BD<CR>

    "" Tagbar
    nmap <silent> <F8> :TagbarToggle<CR>

    "" NERDTree
    let g:NERDTreeChDirMode = 2 " switch CWD
    nmap <silent> <F7> :NERDTreeToggle<CR>
    nmap <silent> <leader><F7> :NERDTreeFind<CR>

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

    "" terraform-vim
    let g:terraform_fmt_on_save=1

    "" vim-slime
    let g:slime_target = "tmux"
    let g:slime_paste_file = "$HOME/.slime_paste"
    let g:slime_dont_ask_default = 1
    let g:slime_default_config = {"socket_name": "default", "target_pane": ":.1"}

    "" Golang specific
    " run :GoBuild or :GoTestCompile based on the go file (vim-go-tutorial)
    function! s:build_go_files()
        let l:file = expand('%')
        if l:file =~# '^\f\+_test\.go$'
            call go#cmd#Test(0, 1)
        elseif l:file =~# '^\f\+\.go$'
            call go#cmd#Build(0)
        endif
    endfunction

    autocmd FileType go nmap <leader>b  :<C-u>call <SID>build_go_files()<CR>
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)

    "autocmd FileType go nmap <leader>d <Plug>(go-doc)

    let g:go_list_type = "quickfix"
    let g:go_fmt_command = "goimports"

    let g:go_def_mapping_enabled = 0
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_extra_types = 1

    " Tagbar config
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }
    '';
  };

  home.file.".local/share/nvim/site/vim-bufkill/start".recursive = true;
  home.file.".local/share/nvim/site/vim-bufkill/start".source = ./files/vim-plugins/vim-bufkill;
  home.file.".local/share/nvim/site/vim-numbertoggle/start".recursive = true;
  home.file.".local/share/nvim/site/vim-numbertoggle/start".source = ./files/vim-plugins/vim-numbertoggle;
  home.file.".local/share/nvim/site/vim-dispatch-neovim/start".recursive = true;
  home.file.".local/share/nvim/site/vim-dispatch-neovim/start".source = ./files/vim-plugins/vim-dispatch-neovim;

}
