vim.opt.mouse = "a"

vim.opt.termguicolors = true

-- Theme setup
-- configure nvcode-color-schemes
vim.g.nvcode_termcolors = 256

vim.g.nord_bold = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_uniform_diff_background = 1
vim.g.nord_uniform_status_lines = 1


vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.backspace = indent,eol,start

-- Custom list chars
vim.opt.encoding = "utf-8"
vim.opt.listchars = {
	eol = '↵',
	trail = '•',
	tab = '| '
}

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Show line numbers and ruler
vim.opt.number = true
vim.opt.colorcolumn = "81"

vim.opt.autoindent = true -- autosave files on :make
vim.opt.updatetime = 250  -- update each 250ms
vim.opt.synmaxcol = 250   -- syntax hi. only for first 250 chars. Speed improvement
                          -- for files with long lines

--  sudo write
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true, silent = true })

-- Set persistent undo
HOME = os.getenv("HOME")
vim.opt.undofile = true
vim.opt.undodir = HOME .. "/.vim/undodir"

-- Disable swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- buffers navigation
vim.api.nvim_set_keymap("n", "<leader>[", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>]", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>;", ":BD<CR>", { noremap = true, silent = true })

-- fzf
vim.api.nvim_set_keymap("n", "<C-p>", ":FZF<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>'", ":Buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":Tags<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>=", ":History<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>se", ":Ag<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gs", ":GFiles?<CR>", { noremap = true, silent = true })

-- run fzf in floating window
vim.g.fzf_layout = {
	window = {
		width = 0.9,
		height = 0.8,
		highlight = 'FloatermBorder',
		border = 'rounded'
	}
}

-- vim-floaterm
vim.g.floaterm_autoclose = 1 -- close window on success
vim.g.floaterm_autohide = 2  -- always autohide

vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.8
vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

-- Set floating window border line color
vim.api.nvim_set_hl(0, 'FloatermBorder',{ bg = '#2e3440',  fg = '#81a1c1' })

vim.api.nvim_set_keymap("n", "<leader>e", ":FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>e", "<C-\\><C-n>:FloatermToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ftn", ":FloatermNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<leader>ftn", "<C-\\><C-n>:FloatermNext<CR>", { noremap = true, silent = true })

-- Vimwiki
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_list = {
	{
		path = '~/.vimwiki/',
		syntax = 'markdown',
		ext = '.md',
	}
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function(args)
    vim.keymap.set('n', '<leader>t', ':VimwikiToggleListItem<CR>', { noremap = true })
  end
})

vim.api.nvim_set_hl(0, 'VimwikiHeader1',{ bg = '#2e3440',  fg = '#8fbcbb' })
vim.api.nvim_set_hl(0, 'VimwikiHeader2',{ bg = '#2e3440',  fg = '#a3be8c' })
vim.api.nvim_set_hl(0, 'VimwikiHeader3',{ bg = '#2e3440',  fg = '#5e81ac' })
vim.api.nvim_set_hl(0, 'VimwikiHeader4',{ bg = '#2e3440',  fg = '#ebcb8b' })
vim.api.nvim_set_hl(0, 'VimwikiHeader5',{ bg = '#2e3440',  fg = '#d08770' })
vim.api.nvim_set_hl(0, 'VimwikiHeader6',{ bg = '#2e3440',  fg = '#bf616a' })

-- terraform-vim
vim.g.terraform_fmt_on_save = 1

-- vim-slime
vim.g.slime_target = "tmux"
vim.g.slime_paste_file = HOME .. "/.slime_paste"
vim.g.slime_dont_ask_default = 1
vim.g.slime_default_config = {
	socket_name = "default",
	target_pane = ":.1",
}

-- vim-go

-- run :GoBuild or :GoTestCompile based on the go file
local function go_build()
  local fname = vim.fn.expand("%:p:h") .. "/" .. vim.fn.expand("%:p:r")
  local go_build = "go build " .. fname .. ".go"
  local go_test = "go test " .. fname .. "_test.go"
  if vim.fn.filereadable(go_build) == 1 then
	vim.cmd(":!go build " .. fname .. ".go")
  elseif vim.fn.filereadable(go_test) == 1 then
	vim.cmd(":!go test " .. fname .. "_test.go")
  else
	vim.cmd(":GoBuild")
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
	vim.keymap.set('n', '<leader>b', function() go_build() end, { noremap = true })
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
	vim.keymap.set('n', '<leader>r', '<Plug>(go-run)', { noremap = true })
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
	vim.keymap.set('n', '<leader>t', '<Plug>(go-test)', { noremap = true })
  end
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
	vim.keymap.set('n', '<leader>c', '<Plug>(go-coverage-toggle)', { noremap = true })
  end
})


vim.g.go_list_type = "quickfix"
vim.g.go_fmt_command = "goimports"

vim.g.go_gopls_enabled = 1
vim.g.go_gopls_options = {'-remote=auto'}

vim.g.go_code_completion_enabled = 0
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0

-- colorizer
require'colorizer'.setup()

-- Nvim-Tree
vim.api.nvim_set_keymap("n", "<F7>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><F7>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

require'nvim-tree'.setup {
  renderer = {
    indent_markers = {
      enable = true;
    },
  },
}

-- vim-test
vim.cmd([[
function! CustomFloatermStrategy(cmd)
  execute 'FloatermNew --name=vim-test --autoclose=0 --height=0.4 --width=0.6 --wintype=float --position=topright '.a:cmd
endfunction

let g:test#custom_strategies = {'custom_floaterm': function('CustomFloatermStrategy')}
let g:test#strategy = 'custom_floaterm'
]])

-- lualine
require'lualine'.setup{
  options = { theme  = 'catppuccin-macchiato' },
}

-- bufferline
require("bufferline").setup{
  options = {
    -- separator_style = "padded_slant",
    diagnostics = "nvim_lsp",
  }
}

-- Telescope
require('telescope').setup{
  -- ...
  defaults = {
    prompt_prefix = "🔍",
  }
}

-- nvim-lspfuzzy
require('lspfuzzy').setup{}

-- nvim-cmp
local lspkind = require "lspkind"
lspkind.init()

local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },

  mapping = cmp.mapping.preset.insert(),

  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'ultisnips' }, -- For ultisnips users.
    { name = 'buffer', keyword_length = 3 },
    { name = 'treesitter' },
    { name = 'emoji' }
  },

  formatting = {
    -- Youtube: How to set up nice formatting for your sources.
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buf]",
        nvim_lsp = "[LSP]",
        path = "[Path]",
        treesitter = "[Tree]",
        ultisnips = "[Ulti]"
      },
    },
  },

  experimental = {
    native_menu = false,
    ghost_text = true,
  }
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp_document_symbol' }
  },
  {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
  {
    { name = 'path' }
  },
  {
    { name = 'cmdline' }
  })
})

-- lsp_signature
lsp_signature_cfg = {
  handler_opts = {
    border = "none"   -- double, single, shadow, none
  },
  extra_trigger_chars = {"(", ","}
}

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsp-config
-- vim.lsp.set_log_level("debug")
local nvim_lspconfig = require('lspconfig')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

require('lsp_signature').on_attach(lsp_signature_cfg)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- workspaces
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local lsp_default_config = {on_attach = on_attach, capabilties = capabilties}
local servers = {
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.21.14-standalone-strict/all.json"] = "/*.k8s.yaml",
        },
      },
    }
  },
  terraformls = {},
  gopls = {
    filetypes = { 'go', 'gomod', 'gohtmltmpl', 'gotexttmpl' },
    cmd = {'gopls','--remote=auto'},
    flags = { allow_incremental_sync = true, debounce_text_changes = 1000 },
    settings = {
      gopls = {
        analyses = { unusedparams = true, unreachable = false },
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'fuzzy',
        diagnosticsDelay = '500ms',
        symbolMatcher = 'fuzzy',
        gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
        buildFlags = { '-tags', 'lint' },
        -- hoverKind = "FullDocumentation",
      },
    },
  }
}

for server, config in pairs(servers) do
  nvim_lspconfig[server].setup(vim.tbl_deep_extend('force', lsp_default_config, config))
end

-- devicons
require'nvim-web-devicons'.setup {
 -- globally enable default icons (default to false)
  default = true;
}

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
}

require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
		vimwiki = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

vim.cmd("colorscheme catppuccin-macchiato")

require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
